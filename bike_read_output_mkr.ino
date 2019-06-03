/* 
 *  SD card configuration: MKR MEM SHIELD or d1 mini sd shield
 */

#include <Streaming.h>
//#include <SPI.h> // needed for esp32, not for others
#include <SD.h>

const int chipSelect = 4; // 4 for most things, 5 for esp32
bool sdBegan = false;

bool firstRead = true;

int writes = 0;

unsigned long lightOffMillis = 0;

void setup() {
  Serial.begin(9600);

  Serial1.begin(9600);

  sdBegan = SD.begin(chipSelect);

//  pinMode(LED_BUILTIN, OUTPUT);

//  pinMode(13, INPUT);

  // write to SD card
  if (sdBegan) {
      Serial << "SD card initialized" << endl;
    
      lightOffMillis = millis() + 1000;
    
      File dataFile = SD.open("BikeData.txt", FILE_WRITE);

      if (dataFile) {
        dataFile << "Bike turned on" << endl;

        dataFile.close();
      }
  } else
      Serial << "SD card failed to initialize" << endl;
}

void loop() {
  // handle input
  if (Serial1.available()) {
    if (firstRead) {
      Serial1.readStringUntil('\n');
      firstRead = false;

      Serial << "first read" << endl;

      lightOffMillis = millis() + 500;

      return;
    }

//    Serial.readString();
    
//    if (sdBegan) {
//      File dataFile = SD.open("BikeData.txt", FILE_WRITE);
//
//      if (dataFile) {
//        dataFile << millis() << ": i work : " << Serial.readStringUntil('\n') << endl;
//
//        dataFile.close();
//
//        lightOffMillis = millis() + 100;
//      }
//      else
//        Serial << "Couldn't write to file" << endl;
//    }

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

//    Serial << "read: ";
//    Serial << ampHours << ", ";
//    Serial << volts << ", ";
//    Serial << amps << ", ";
//    Serial << speed << ", ";
//    Serial << distance << ", ";
//    Serial << degreesC << ", ";
//    Serial << rpm << ", ";
//    Serial << humanWatts << ", ";
//    Serial << nmRiderTorque << ", ";
//    Serial << throttleIn << ", ";
//    Serial << throttleOut << ", ";
//    Serial << acceleration << ", ";
//    Serial << "FLAGS: " << flags << endl;

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

        lightOffMillis = millis() + 100;
      }
      else
        Serial << "Couldn't write to file" << endl;
    }
  }

  // if there have been a certain number of writes, print and remove the file
  // later this can be adapted to upload when connected to wifi
  if (writes >= 5 && false) { // DISABLED
    File dataFile = SD.open("BikeData.txt", FILE_READ);

    writes = 0;

    if (dataFile) {
      while (dataFile.available()) {
        Serial.write(dataFile.read());
      }
      
      dataFile.close();
    }
    // if the file isn't open, pop up an error:
    else {
      Serial.println("error opening BikeData.txt");
    }

    SD.remove("BikeData.txt");
  }

  if (millis() >= lightOffMillis) {
//    digitalWrite(LED_BUILTIN, HIGH);
//    
//    if (millis() >= lightOffMillis + 1000) {
//      lightOffMillis = millis() + 10;
//      digitalWrite(LED_BUILTIN, LOW);
//    }
//  } else {
//    digitalWrite(LED_BUILTIN, LOW);

  }
}
