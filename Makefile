PORT := /dev/cu.usbserial-01DFA28F
#PORT := /dev/cu.usbserial-1413401

all: clean setup build repl

clean:
	rm -rf ./output

flash.erase:
	esptool.py --port $(PORT) erase_flash

setup:
	pip install pyserial
	pip install rshell
	pip install adafruit-ampy

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

undeploy:
	ampy -p ${PORT} rmdir /

deploy:
	ampy -p ${PORT} put ./src/upy /flash/upy
	# ampy -p ${PORT} put ./src/web /flash/web
	ampy -p ${PORT} put ./src/webthing /flash/webthing
	ampy -p ${PORT} put ./src/example /flash/example
	ampy -p ${PORT} put ./src/config.py /flash/config.py
	ampy -p ${PORT} put ./src/connect.py flash/connect.py
	ampy -p ${PORT} put ./src/start.py flash/start.py
	ampy -p ${PORT} put ./src/main.py flash/main.py
