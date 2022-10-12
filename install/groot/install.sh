#!/usr/bin/env bash

set eu
cd $(dirname $0)

_build() {
  # Build && install Groot
  mkdir -p $HOME/.local/src && cd $HOME/.local/src
  git clone https://github.com/BehaviorTree/Groot.git
  cd Groot
  git submodule update --init --recursive
  mkdir build
  cd build
  cmake ..
  make -j4
  sudo make install
}

_linux_install() {
  # Install dependencies
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
  elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
  elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
  else
    echo "Can not detect destribution\n" >&2
    return
  fi

  case "$OS" in
  Ubuntu)
    sudo apt install qtbase5-dev libqt5svg5-dev libzmq3-dev libdw-dev
    _build
    ldconfig
    ;;
  *)
    echo "Installer for $OS is not prepared yet\n" >&2
    return
    ;;
  esac
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
