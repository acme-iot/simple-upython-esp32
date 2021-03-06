#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo $0: usage: build.sh port
    exit 1
fi

port=$1

mkdir ./output
cd ./output

git clone --depth 1 https://github.com/trentmillar/MicroPython_ESP32_psRAM_LoBo.git
# yes | cp -rf ./../artifacts/sdkconfig ./MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/sdkconfig
cd ./MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD

./BUILD.sh -p $port erase
./BUILD.sh -p $port -j4 -v all
./BUILD.sh -p $port flash

cd ./components/mpy_cross_build/mpy-cross
make