/* 
 *  SD card configuration: MKR MEM SHIELD or d1 mini sd shield
 */

#include <Streaming.h>
//#include <SPI.h> // needed for esp32, not for others
#include <SD.h>
#include <WiFiNINA.h>
#include "credentials.h"

// sd variables
const int chipSelect = 4; // 4 for most things, 5 for esp32
bool sdBegan = false;

// -------

bool firstRead = true;

bool newData = false;

unsigned long lastSerialMillis = 0;
const int serialTimeout = 5000;

//unsigned long lightOffMillis = 0;

void setup() {
  Serial.begin(9600);

  Serial1.begin(115200); // set this back

  sdBegan = SD.begin(chipSelect);

//  pinMode(LED_BUILTIN, OUTPUT);

//  pinMode(13, INPUT);

  // write to SD card
  if (sdBegan) {
      Serial << "SD card initialized" << endl;
    
//      lightOffMillis = millis() + 1000;
    
      File dataFile = SD.open("BikeData.txt", FILE_WRITE);

      if (dataFile) {
        dataFile << "Arduino turned on" << endl;

        dataFile.close();
      }
  } else
      Serial << "SD card failed to initialize" << endl;

  lastSerialMillis = millis();
}

void loop() {
  // debug - allow upload to be triggered from serial moniter
  if (Serial.available()) {
    lastSerialMillis = millis();
    newData = true;
    while (Serial.available()) {
      Serial << "Debug received " << Serial.readString() << endl;
    }
  }
  
  // handle input
  if (Serial1.available()) {
    lastSerialMillis = millis();
    
    if (firstRead) {
      Serial << "first read" << endl;
      
      Serial << Serial1.readStringUntil('\n') << endl;
      firstRead = false;

//      lightOffMillis = millis() + 500;

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
        << flags << endl;

        dataFile.close();

        newData = true;

//        lightOffMillis = millis() + 100;
      }
      else
        Serial << "Couldn't write to file" << endl;
    }
  }

  // if the bike stopped giving data, try to upload
  if (millis() - lastSerialMillis >= serialTimeout && newData) {
    firstRead = true;
    
    Serial << "Attempting to connect" << endl;
    
    boolean connected = connect(ssid, pass, 10);

    if (!connected) {
      Serial << "no connection" << endl;
      // low power mode and try again later
    }
    else
    {
      // we have a wifi connection, attempt to upload the file
      Serial << "uploading file" << endl;
      File dataFile = SD.open("BikeData.txt", FILE_READ);

      WiFiClient client;
      client.connect("none.cs.umass.edu", 8099);

      // what if the server was down?
  
      if (dataFile) {
        // upload the file
        char data[1024];

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
          }
        }
        
        client.stop();
     
        dataFile.close();
      }
    }

    WiFi.end();

//    SD.remove("BikeData.txt");
  }

//  if (millis() >= lightOffMillis) {
////    digitalWrite(LED_BUILTIN, HIGH);
////    
////    if (millis() >= lightOffMillis + 1000) {
////      lightOffMillis = millis() + 10;
////      digitalWrite(LED_BUILTIN, LOW);
////    }
////  } else {
////    digitalWrite(LED_BUILTIN, LOW);
//
//  }
}


boolean connect(char* ssid, char* password, int maxAttempts) {
  
  byte t=0;
  int status = WiFi.status();
  while ( ( status != WL_CONNECTED) || (WiFi.RSSI() <= -90) || (WiFi.RSSI() ==0) ) {  
   // attempt to connect to WiFi network:
   status = WiFi.begin(ssid, password);     // Connect to network.
   delay(4000);                                // wait 4 seconds for connection:
   if( t++ > maxAttempts){ // try-counter max
    Serial1.readString(); // clear buffer
    WiFi.end();
    return false;
   }
  }
  Serial1.readString();
  return true;
}
