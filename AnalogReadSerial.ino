#include <Arduino.h>
#include "wiring_private.h"

// Create the new UART instance assigning it to pin 0 and 1
Uart mySerial (&sercom3, 0, 1, SERCOM_RX_PAD_1, UART_TX_PAD_0);

void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);

  pinPeripheral(0, PIO_SERCOM); //Assign RX function to pin 0
  pinPeripheral(1, PIO_SERCOM); //Assign TX function to pin 1
}

void loop() {
  while (mySerial.available()) {
    Serial.println(mySerial.readStringUntil('\n'));
  }
}

// Attach the interrupt handler to the SERCOM
void SERCOM3_Handler()
{
  mySerial.IrqHandler();
}
