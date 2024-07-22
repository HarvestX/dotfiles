#!/usr/bin/env bash

set eu
cd $(dirname $0)

_linux_install() {
  # Install Open OCD
  mkdir -p $HOME/.local/src && cd $HOME/.local/src
  git clone git://git.code.sf.net/p/openocd/code openocd -b v0.12.0
  cd openocd
  ./bootstrap
  ./configure --prefix=$HOME/.local
  make install
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
