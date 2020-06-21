# MicroPython with WebThing support

These steps are for flashing a board with the latest MicroPython binary (https://github.com/loboris/MicroPython_ESP32_psRAM_LoBo/wiki
) plus [WebThings](https://iot.mozilla.org/wot/) support
- `make wt.setup` install dependencies
- `make wt.build` flash the board with binary
- `make wt.repl` start rshell and connect to board
- `make wt.clean` clean output dir containing build dependencies


## Requirements

- ESP32 board
- Serial port to connect to board

#### First Steps

All that is needed once the serial port is connected is to replace the `PORT` in the make file, (/dev/cu.usbserial-01DFA28F) with the name of the connected serial port. This can be found using `ls /dev/cu*` on the MacOS.

#### REPL

usage, refer to https://github.com/dhylands/rshell#sample-session

run `make wt.repl`

