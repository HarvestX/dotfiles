#!/usr/bin/env bash
set eu
cd `dirname $0`

VERSION=v0.7.0

[ -e temp ] && rm -rf temp

mkdir temp
cd temp
wget https://github.com/neovim/neovim/releases/download/$VERSION/nvim.appimage

chmod u+x nvim.appimage
mv nvim.appimage nvim
