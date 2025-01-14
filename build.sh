#!/bin/bash

set -e
set -x

if [ ! -d "./emsdk" ]; then
  git clone https://github.com/emscripten-core/emsdk.git --branch 1.39.20
  ./emsdk/emsdk install 1.39.20-fastcomp
  ./emsdk/emsdk activate 1.39.20-fastcomp
fi

source ./emsdk/emsdk_env.sh >/dev/null 2>&1

if [ "$1" = "clean" ]; then
  emmake make -C tinyemu/ -f Makefile.js clean
fi
emmake make -C tinyemu/ -f Makefile.js -j$(nproc --all)