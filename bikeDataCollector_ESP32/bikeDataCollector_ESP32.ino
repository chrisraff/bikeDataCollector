#include <Streaming.h>
#include <WiFi.h>

#include "FS.h"
#include "SD.h"
#include "SPI.h"

#define RXD1 16
#define TXD1 17

#define WAKEUP_PIN GPIO_NUM_4

// sd variables
const int chipSelect = 5;  // 4 for most things, 5 for esp32
bool sdBegan = false;

// variables for reading from serial
bool firstRead = true;  // for discarding first serial values (most likely bad data)
unsigned long lastSerialMillis = 0;  // for recording time of last serial data input
const int serialTimeout = 5000;  // milliseconds of no data before timeout (bike is considered off)
int lastAssistLevel = -1;
bool lightStatus = false;

// variables for uploading to server
int bikeId = -1; // this default value is replaced with the value loaded from the SD card
char *ssid, *pass; // wifi credentials
bool initializedWifiCredentials = false;
RTC_DATA_ATTR bool newData = false;  // for determining whether an upload is needed
const int uploadReattemptMillis = 20 * 60 * 1000; // time to wait before uploading again
unsigned long lastUploadAttemptMillis = 0;

unsigned long lastLightMillis = 0;


void setup() {
  Serial.begin(9600);
  Serial1.begin(9600, SERIAL_8N1, RXD1, TXD1);

  delay(1000);
  Serial << "Arduino is on" << endl;

  btStop();
  WiFi.mode(WIFI_OFF);

  sdBegan = SD.begin(chipSelect);  // determine the presence of SD card

  pinMode(LED_BUILTIN, OUTPUT);

  // write to SD card if SD card exists
  if (sdBegan) {
    Serial << "SD card initialized" << endl;

    // log the arduino powering on
    File dataFile = SD.open("/BikeData.txt", FILE_APPEND);
    if (!dataFile)
      dataFile = SD.open("/BikeData.txt", FILE_WRITE);

    if (dataFile) {
      dataFile << "Arduino turned on" << endl;
      dataFile.close();
    }

    // get the wifi credentials and bike id
    File configFile = SD.open("/BikeConf.txt", FILE_READ);
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
  esp_sleep_enable_ext0_wakeup(WAKEUP_PIN, 1);
}

void loop() {
  if (millis() - lastLightMillis > 500) {
    lastLightMillis = millis();
    digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
  }

  // handle input
  if (Serial.available()) {
    lastSerialMillis = millis();

    if (firstRead) {  // discard first line of data
      Serial << "first read: " << endl;
      // log that the bike turned back on
      if (sdBegan) {
        File dataFile = SD.open("/BikeData.txt", FILE_APPEND);
        if (dataFile) {
          dataFile << millis() << ": Bike turned on" << endl;
          dataFile.close();

          newData = true;
        }
      }

      Serial << Serial.readStringUntil('\n') << endl;
      firstRead = false;
      return;
    }

    float ampHours = Serial.parseFloat();
    float volts = Serial.parseFloat();
    float amps = Serial.parseFloat();
    float speed = Serial.parseFloat();
    float distance = Serial.parseFloat();
    float degreesC = Serial.parseFloat();
    float rpm = Serial.parseFloat();
    int humanWatts = Serial.parseInt(); // doesn't appear to be a float?
    float nmRiderTorque = Serial.parseFloat();
    float throttleIn = Serial.parseFloat();
    float throttleOut = Serial.parseFloat();
    float acceleration = Serial.parseFloat();
    String flags = Serial.readStringUntil('\n');
    flags.trim();


    // write to SD card
    if (sdBegan) {

      File dataFile = SD.open("/BikeData.txt", FILE_APPEND);
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

  if (Serial1.available()) {
    Serial1.read(); // :
    Serial1.read(); // 26
    Serial1.read(); // F
    Serial1.read(); // 2
    lastAssistLevel = Serial1.read();

    lightStatus = lastAssistLevel >= 128;

    if (lastAssistLevel >= 128) {
      lastAssistLevel -= 128;
    }

    Serial1.readStringUntil('\n'); // clear the rest of the buffer
  }

  // if the bike stopped giving data (turned off), try to upload
  bool dataStoppedFlowing = millis() - lastSerialMillis >= serialTimeout;
  bool allowedToAttempt = true; // millis() - lastUploadAttemptMillis >= uploadReattemptMillis;
  if (dataStoppedFlowing && allowedToAttempt && newData) {
    firstRead = true;  // reset firstRead for serial input

    Serial << "Attempting to connect" << endl;
    digitalWrite(LED_BUILTIN, HIGH);
    WiFi.mode(WIFI_STA);
    WiFi.begin(ssid, pass);
    unsigned long connectionAttemptTimeoutMillis = millis() + 30000;
    while (WiFi.status() != WL_CONNECTED && millis() < connectionAttemptTimeoutMillis) {
      yield;
    }
    if (WiFi.status() != WL_CONNECTED) {
      Serial << "no connection, sleeping" << endl;
      digitalWrite(LED_BUILTIN, LOW);
      // go into low power mode and try again later
      lastUploadAttemptMillis = millis();
      WiFi.mode(WIFI_OFF);
      //   LowPower.sleep(uploadReattemptMillis);
      esp_sleep_enable_timer_wakeup(uploadReattemptMillis * 1000);
      esp_deep_sleep_start();
      // note that you will never get to this part of the code
      return;
    }
    else
    {
      // upload the file
      Serial << "uploading file" << endl;
      File dataFile = SD.open("/BikeData.txt", FILE_READ);

      WiFiClient client;
      int clientStatus = client.connect("none.cs.umass.edu", 8099);
      bool handshake = false;

      // handshake with server
      File handshakeFile = SD.open("/ServerCr.txt", FILE_READ);
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
        digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
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
            SD.remove("/BikeData.txt");
          }
        }
        client.stop();
        dataFile.close();
      }
    }

    WiFi.mode(WIFI_OFF);

    digitalWrite(LED_BUILTIN, LOW);

    if (newData) {
      // failed to upload, try again later
      Serial << "Failed to upload, sleeping for a bit" << endl;
      lastUploadAttemptMillis = millis();
      esp_sleep_enable_timer_wakeup(uploadReattemptMillis * 1000);
      esp_deep_sleep_start();
      return;
    }
    else {
      Serial << "going to sleep" << endl;
      esp_deep_sleep_start();
    }
  }
}
