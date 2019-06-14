#include <Streaming.h>
#include <SD.h>
#include <WiFiNINA.h>
#include <ArduinoLowPower.h>
#include "wiring_private.h"

// sd variables
const int chipSelect = 4;  // 4 for most things, 5 for esp32
bool sdBegan = false;

// variables for reading from serial
bool firstRead = true;  // for discarding first serial values (most likely bad data)
unsigned long lastSerialMillis = 0;  // for recording time of last serial data input
const int serialTimeout = 5000;  // milliseconds of no data before timeout (bike is considered off)
int lastAssistLevel = -1;
bool lightStatus = false;
Uart softSerial (&sercom3, 0, 1, SERCOM_RX_PAD_1, UART_TX_PAD_0);

// variables for uploading to server
int bikeId = -1; // this default value is replaced with the value loaded from the SD card
char *ssid, *pass; // wifi credentials
bool initializedWifiCredentials = false;
bool newData = false;  // for determining whether an upload is needed
const int uploadReattemptMillis = 20 * 60 * 1000; // time to wait before uploading again
unsigned long lastUploadAttemptMillis = 0;

// function headers
void wakeMeUpInside();
bool connect(char*, char*, int);

unsigned long lastLightMillis = 0;

void setup() {
  Serial.begin(9600);
  Serial1.begin(9600);

  softSerial.begin(9600);
  pinPeripherla(0, PIO_SERCOM); // RX
  pinPeripheral(1, PIO_SERCOM); // TX

  sdBegan = SD.begin(chipSelect);  // determine the presence of SD card

  pinMode(LED_BUILTIN, OUTPUT);

  // write to SD card if SD card exists
  if (sdBegan) {
    Serial << "SD card initialized" << endl;

    // log the arduino powering on
    File dataFile = SD.open("BikeData.txt", FILE_WRITE);
    if (dataFile) {
      dataFile << "Arduino turned on" << endl;
      dataFile.close();
    }

    // get the wifi credentials and bike id
    File configFile = SD.open("BikeConf.txt");
    if (configFile) {
      initializedWifiCredentials = true;

      bikeId = configFile.parseInt();

      configFile.readStringUntil('\n');

      String ssid_s = configFile.readStringUntil('\n');
      ssid = new char[ssid_s.length()]();
      ssid_s.toCharArray(ssid, ssid_s.length());

      String pass_s = configFile.readStringUntil('\n');
      pass = new char[pass_s.length()]();
      pass_s.toCharArray(pass, pass_s.length());

      configFile.close();
    }
  }
  else Serial << "SD card failed to initialize" << endl;
  lastSerialMillis = millis();
  LowPower.attachInterruptWakeup(7, wakeMeUpInside, CHANGE); // set attachInterruptWakeup pin

  // go to sleep until the bike turns on
  LowPower.sleep();
}

void loop() {
  if (millis() - lastLightMillis > 500) {
    lastLightMillis = millis();
    digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
  }

  // debug - allow upload to be triggered from serial moniter
  if (Serial.available()) {
    lastSerialMillis = millis();
    newData = true;
    while (Serial.available()) {
      Serial << "Debug received " << Serial.readString() << endl;

      Serial << "sd began: " << sdBegan << endl;
      Serial << "bike id: " << bikeId << endl;
    }
  }

  // handle input
  if (Serial1.available()) {
    lastSerialMillis = millis();

    if (firstRead) {  // discard first line of data
      Serial << "first read" << endl;
      // log that the bike turned back on
      if (sdBegan) {
        File dataFile = SD.open("BikeData.txt", FILE_WRITE);
        if (dataFile) {
          dataFile << millis() << ": Bike turned on" << endl;
          dataFile.close();

          newData = true;
        }
      }

      Serial << Serial1.readStringUntil('\n') << endl;
      firstRead = false;
      return;
    }

    float ampHours = Serial1.parseFloat();
    float volts = Serial1.parseFloat();
    float amps = Serial1.parseFloat();
    float speed = Serial1.parseFloat();
    float distance = Serial1.parseFloat();
    float degreesC = Serial1.parseFloat();
    float rpm = Serial1.parseFloat();
    int humanWatts = Serial1.parseInt(); // doesn't appear to be a float?
    float nmRiderTorque = Serial1.parseFloat();
    float throttleIn = Serial1.parseFloat();
    float throttleOut = Serial1.parseFloat();
    float acceleration = Serial1.parseFloat();
    String flags = Serial1.readStringUntil('\n');


    // write to SD card
    if (sdBegan) {
      File dataFile = SD.open("BikeData.txt", FILE_WRITE);
      if (dataFile) {
        dataFile << millis() << ": " << ampHours << ", " << volts << ", "
                 << amps << ", " << speed << ", " << distance << ", " << degreesC << ", "
                 << rpm << ", " << humanWatts << ", " << nmRiderTorque << ", "
                 << throttleIn << ", " << throttleOut << ", " << acceleration << ", "
                 << flags << ", " << lastAssistLevel << ", " << lightStatus << endl;

        dataFile.close();

        newData = true;
      }
      else
        Serial << "Couldn't write to file" << endl;
    }
  }

  // get assist level
  if (softSerial.available()) {
    softSerial.read(); // :
    softSerial.read(); // 26
    softSerial.read(); // F
    softSerial.read(); // 2
    lastAssistLevel = softSerial.read();

    if (lastAssistLevel > 128) {
      lastAssistLevel -= 128;
      lightStatus = true;
    }

    softSerial.readStringUntil('\n'); // clear the rest of the buffer
  }

  // if the bike stopped giving data (turned off), try to upload
  bool dataStoppedFlowing = millis() - lastSerialMillis >= serialTimeout;
  bool allowedToAttempt = millis() - lastUploadAttemptMillis >= uploadReattemptMillis;
  if (dataStoppedFlowing && allowedToAttempt && newData) {
    firstRead = true;  // reset firstRead for serial input

    Serial << "Attempting to connect" << endl;
    boolean connected = connect(ssid, pass, 10);
    if (!connected) {
      Serial << "no connection, sleeping" << endl;
      // go into low power mode and try again later
      digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
      lastUploadAttemptMillis = millis();
      WiFi.end();
      LowPower.sleep(uploadReattemptMillis);
      return;
    }
    else
    {
      // upload the file
      Serial << "uploading file" << endl;
      File dataFile = SD.open("BikeData.txt", FILE_READ);

      WiFiClient client;
      int clientStatus = client.connect("none.cs.umass.edu", 8099);
      bool handshake = false;

      // handshake with server
      File handshakeFile = SD.open("ServerCr.txt", FILE_READ);
      if (handshakeFile) {
        String mine = handshakeFile.readStringUntil('\n');
        client << mine;
        String theirs = handshakeFile.readStringUntil('\n');
        theirs.trim();
        String actual = client.readStringUntil('\n');

        if (actual == theirs) {
          handshake = true;
        }
        else {
          Serial << "handshake failed" << endl;
          client.stop();
        }
      }

      if (dataFile && clientStatus == 1 && handshake) {
        client << "Bike ID: " << bikeId << endl;

        // upload the file
        char data[1024];  // make 1 KB packet to send

        boolean fileHasEnded = false;

        while (!fileHasEnded) {
          int i = 0;
          for (i = 0; i < 1024; i++) {
            int nextChar = dataFile.read();
            if (nextChar == -1) {
              fileHasEnded = true;
              break;
            }
            data[i] = (char) nextChar;
          }
          client << String(data).substring(0, i);
          delay(250);
        }
        client << "<END>";
        Serial << "sent file, waiting for acknowledgement" << endl;

        // wait for acknowledgement
        unsigned long startMillis = millis();
        while (millis() - startMillis < 20000 && !client.available()) {
          yield;
        }
        if (client.available()) {
          String ack = client.readString();
          Serial << "got: " << ack << endl;

          if (ack.equals("great")) {
            Serial << "great, acknowledged" << endl;
            // the file successfully uploaded
            newData = false;
            SD.remove("BikeData.txt");
          }
        }
        client.stop();
        dataFile.close();
      }
    }

    WiFi.end();

    if (newData) {
      // failed to upload, try again later
      Serial << "Failed to upload, sleeping for a bit" << endl;
      lastUploadAttemptMillis = millis();
      LowPower.sleep(uploadReattemptMillis);
      return;
    }
    else {
      Serial << "going to sleep, serial will stop working" << endl;
      LowPower.sleep();
    }
  }
}


void wakeMeUpInside() {
  // Intentionally empty
}


void SERCOM3_Handler() {
  softSerial.IrqHandler();
}


boolean connect(char* ssid, char* password, int maxAttempts) {
  byte t = 0;
  int status = WiFi.status();
  while ( ( status != WL_CONNECTED) || (WiFi.RSSI() <= -90) || (WiFi.RSSI() == 0) ) {
    // attempt to connect to WiFi network:
    status = WiFi.begin(ssid, password);  // Connect to network.
    delay(4000);  // wait 4 seconds for connection:
    if ( t++ > maxAttempts) {  // try-counter max
      Serial1.readString();  // clear buffer
      WiFi.end();
      return false;
    }
  }
  Serial1.readString();
  return true;
}
