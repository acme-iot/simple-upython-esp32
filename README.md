# MicroPython with or without WebThing support

These steps are for flashing a board with MicroPython and not for WebThing support
- `make.flash` esp32 board with uPython
- `make falsh.erase` the board
- `make repl` start repl, uses picocom
- `make build` will build a board with uPython

## using with project

-Requirements, ESP32 board

-Serial port to connect to board

#### steps

All that is needed once the serial port is connected is to replace the `PORT`, (/dev/cu.usbserial-01DFA28F) with the name of the connected serial port. This can be found using `ls /dev/cu*` on the MacOS.


