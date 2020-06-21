PORT := /dev/cu.usbserial-01DFA28F


all: clean setup build repl

clean:
	rm -rf ./output

flash.erase:
	esptool.py --port $(PORT) erase_flash

setup:
	. ./scripts/setup.sh

build:
	. ./scripts/build.sh ${PORT}

repl:
	. ./scripts/repl.sh ${PORT}
