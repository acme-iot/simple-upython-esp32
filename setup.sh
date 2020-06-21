#!/usr/bin/bash

sudo easy_install pip
sudo pip install pyserial

mkdir ./output
cd ./output

git clone --depth 1 https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo.git

yes | cp -rf ./../artifacts/sdkconfig ./MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/sdkconfig

cd ./MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD
./BUILD.sh -j4 all
./BUILD.sh flash

cd ../../

git clone --depth 1 https://github.com/mozilla-iot/webthing-upy.git

sudo pip3 install rshell

cd ./webthing-upy

rshell -a --buffer-size=30 --port=/dev/cu.usbserial-01DFA28F

cd ../

# rm -rf ./MicroPython_ESP32_psRAM_LoBo