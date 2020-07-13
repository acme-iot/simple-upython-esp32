PORT := /dev/cu.usbserial-01DFA28F
#PORT := /dev/cu.usbserial-1413401

.PHONY: build

all.compiled: clean setup flash.erase build build.mpy compile.bytecode upload repl
all.raw: clean setup flash.erase build compile.raw upload repl

clean:
	rm -rf ./output

flash.erase:
	esptool.py --port $(PORT) erase_flash

flash:
	esptool.py --chip esp32 -p $(PORT) write_flash -z 0x1000 ./output/MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/build/MicroPython.bin

setup:
	pip install pyserial
	pip install rshell
	pip install adafruit-ampy

monitor:
	cd ./output/MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/ \
	&& ./BUILD.sh monitor

build.premade: flash.erase
	cd ./output/MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/firmware/esp32_psram_all \
	&& ../flash.sh -p ${PORT}

compile.bytecode:
	rm -rf ./build \
	&& mkdir ./build \
	&& cp ./src/config.py ./build \
	&& cp ./src/connect.py ./build \
	&& cp ./src/start.py ./build \
	&& cp -r ./src/webthing ./build/webthing \
	&& cd ./build \
	&& ../output/mpy-cross ./config.py \
	&& ../output/mpy-cross ./connect.py \
	&& ../output/mpy-cross ./start.py \
	&& cd ./webthing \
	&& ../../output/mpy-cross ./action.py \
	&& ../../output/mpy-cross ./copy.py \
	&& ../../output/mpy-cross ./errors.py \
	&& ../../output/mpy-cross ./event.py \
	&& ../../output/mpy-cross ./eventemitter.py \
	&& ../../output/mpy-cross ./logging.py \
	&& ../../output/mpy-cross ./property.py \
	&& ../../output/mpy-cross ./server.py \
	&& ../../output/mpy-cross ./single_thing.py \
	&& ../../output/mpy-cross ./thing.py \
	&& ../../output/mpy-cross ./types.py \
	&& ../../output/mpy-cross ./utils.py \
	&& ../../output/mpy-cross ./uuid.py \
	&& ../../output/mpy-cross ./value.py \
	&& find ./ -name '*.py' -delete \
	&& find ../ -name '*.py' -delete \
	&& cd .. \
	&& cp ../src/main.py ./ \
	&& cp ../src/boot.py ./ \

compile.raw:
	rm -rf ./build \
	&& mkdir ./build \
	&& cp ./src/main.py ./build \
	&& cp ./src/boot.py ./build \
	&& cp ./src/config.py ./build \
	&& cp ./src/connect.py ./build \
	&& cp ./src/start.py ./build \
	&& cp -r ./src/webthing ./build/webthing \

build:
	. ./scripts/build.sh ${PORT}

repl:
	rshell -a --buffer-size=30 --port=${PORT} repl

build.mpy:
	cd ./output/MicroPython_ESP32_psRAM_LoBo/MicroPython_BUILD/components/mpy_cross_build/mpy-cross \
	&& make \
	&& cp mpy-cross ../../../../../

upload:
	rshell -p ${PORT} rsync -m build /flash
