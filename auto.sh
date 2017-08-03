#!/usr/bin/env bash
#set -x

SRC_FOLDER=src/

./build.sh $@

fswatch -o "$SRC_FOLDER" | xargs -n 1 ./build.sh $@

