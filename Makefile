PORT := /dev/cu.usbserial-01DFA28F
BINARY := esp32-idf4-20191220-v1.12.bin

PHONEY.:
	build

all: flash.write

clean:
	rm -rf ./output
	mkdir ./output

get.bin: clean
	curl -k -o ./output/micropython.bin https://micropython.org/resources/firmware/${BINARY}

flash.erase:
	esptool.py --port $(PORT) erase_flash

flash.write:
	esptool.py --port $(PORT) write_flash -z 0x1000 ./output/micropython.bin

repl:
	picocom $(PORT) -b115200

wt.setup:
	. ./setup.sh

wt.build:
	. ./build.sh ${PORT}

wt.repl:
	. ./repl.sh ${PORT}

wt.clean:
	. ./clean.sh
