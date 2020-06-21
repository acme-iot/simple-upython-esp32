# MicroPython with WebThing support

WebThings source, https://github.com/mozilla-iot/webthing-upy

## Requirements

- ESP32 board
- Serial port to connect to board

#### First Steps

All that is needed once the serial port is connected is to replace the `PORT` in the make file, (/dev/cu.usbserial-01DFA28F) with the name of the connected serial port. This can be found using `ls /dev/cu*` on the MacOS.

These steps are for flashing a board with the latest MicroPython binary (https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo/wiki
) plus [WebThings](https://iot.mozilla.org/wot/) support
- `make setup` install dependencies
- `make build` flash the board with binary
- `make repl` start rshell and connect to board
- `make clean` clean output dir containing build dependencies

#### REPL

usage, refer to https://github.com/dhylands/rshell#sample-session

run `make wt.repl`

in rshell copy all files in `src` to the board
- `cd ./src`
- `rsync . /flash`

then access the repl against the board
- `repl`

