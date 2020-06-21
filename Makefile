PORT := /dev/cu.usbserial-01DFA28F


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
