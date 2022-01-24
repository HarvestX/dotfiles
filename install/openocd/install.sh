#!/usr/bin/env bash

# Install Open OCD
mkdir -p $HOME/.local/src && cd $HOME/.local/src
git clone git://git.code.sf.net/p/openocd/code openocd -b v0.11.0
cd openocd
./bootstrap
./configure --prefix=$HOME/.local
make install
