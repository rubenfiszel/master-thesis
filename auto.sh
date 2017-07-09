#!/usr/bin/env bash
#set -x

SRC_FOLDER=src/

fswatch -o "$SRC_FOLDER" | xargs -n 1 ./build.sh $@

