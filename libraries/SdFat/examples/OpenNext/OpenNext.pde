/*
 * Open all files in the root dir and print their filename
 */
#include <SdFat.h>

// SD chip select pin
const uint8_t chipSelect = SS;

// file system object
SdFat sd;

SdFile file;

// define a serial output stream
ArduinoOutStream cout(Serial);
//------------------------------------------------------------------------------
void setup() {
  char name[13];

  Serial.begin(9600);

  // initialize the SD card at SPI_HALF_SPEED to avoid bus errors with
  // breadboards.  use SPI_FULL_SPEED for better performance.
  if (!sd.begin(chipSelect, SPI_HALF_SPEED)) sd.initErrorHalt();

  // open next file in root.  The volume working directory, vwd, is root
  while (file.openNext(sd.vwd(), O_READ)) {
    file.getFilename(name);
    cout << name << endl;
    file.close();
  }
  cout << "Done" << endl;
}
//------------------------------------------------------------------------------
void loop() {}
