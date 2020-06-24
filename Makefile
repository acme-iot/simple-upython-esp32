PORT := /dev/cu.usbserial-01DFA28F
#PORT := /dev/cu.usbserial-1413401

all: clean setup build repl

clean:
	rm -rf ./output

flash.erase:
	esptool.py --port $(PORT) erase_flash

setup:
	sudo easy_install pip
	sudo pip install pyserial
	sudo pip3 install rshell

build:
	. ./scripts/build.sh ${PORT}

repl:
	rshell -a --buffer-size=30 --port=${PORT}

monitor:
	cd ./output/MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/ \
	&& ./BUILD.sh monitor

pre.build: flash.erase
	cd ./output/MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/firmware/esp32_ota \
	&& ../flash.sh -p ${PORT}
