#!/usr/bin/env bash

set eu
cd $(dirname $0)

_linux_install() {
  # Install Open OCD
  sudo apt update
  sudo apt install -y make libtool pkg-config autoconf automake texinfo
  mkdir -p $HOME/.local/src && cd $HOME/.local/src
  git clone git://git.code.sf.net/p/openocd/code openocd -b v0.12.0
  cd openocd
  ./bootstrap
  ./configure --prefix=$HOME/.local
  make
  make install
  exec $SHELL -l #Reflects openocd installation.
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
