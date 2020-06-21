#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo $0: usage: repl.sh port
    exit 1
fi

port=$1

mkdir ./output
cd ./output

git clone --depth 1 https://github.com/mozilla-iot/webthing-upy.git
cd ./webthing-upy

rshell -a --buffer-size=30 --port=$port

cd ../
