# harbour-rgbwifi
Control a WiFi RGB ledstrip with your Sailfish OS phone!

[![Demo](https://img.youtube.com/vi/CUqqFN2gjLo/0.jpg)](https://www.youtube.com/watch?v=CUqqFN2gjLo)

# Setup
In order to use RGBWiFi you need to setup some things first.

## Things you need
* Sailfish OS smartphone 
* ESP8266
* Local WiFi network
* Some wires
* Power supply
* DC-DC convertor
* RGB IR controller or 3 MOSFETs with the right resistors
* RGB ledstrip

## ESP8266 sketch
* Install the Arduino IDE and download the add-on for the ESP8266 with the built-in board manager
* Download the Arduino sketch from https://github.com/modulebaan/rgbwifi-esp8266-arduino
* Change the WiFi SSID and the password to your local network
* Upload the sketch to the ESP8266

## RGBWiFi app
* Install the Sailfish SDK if you haven't done this yet
* Open the .pro file from this repo with the Sailfish SDK
* Edit the 'ledstrip.py' file with the right IP address of your ESP8266 module
* Build and install the app on your Sailfish OS smartphone

## Hardware
* Connect the wires to the RGB IR controller, you need to figure out yourself which path on the PCB connect to each color MOSFET since those controllers are very different from each supplier on Aliexpress
* Connect the DC-DC convertor between the poyer supply (most of the time 12V) and the ESP8266 (5V)
* Connect the powers upply to the RGB ledstrip
