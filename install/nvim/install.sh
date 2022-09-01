#!/usr/bin/env bash

set eu
cd $(dirname $0)

NVIM_VERSION="0.7.2"

_linux_build() {
  mkdir -p temp
  cd temp

  if ! [ -f v$NIVM_VERSION.tar.gz ]; then
    wget -N https://github.com/neovim/neovim/archive/refs/tags/v${NVIM_VERSION}.tar.gz
  fi

  tar -xvf v$NVIM_VERSION.tar.gz
  mkdir -p $HOME/.local/src
  mv neovim-${NVIM_VERSION} $HOME/.local/src
  cd $HOME/.local/src/neovim-${NVIM_VERSION}
  make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local
  make install
}

_linux_install() {
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
    echo "Can not detect destribution" >&2
    return
  fi

  case "$(dpkg --print-architecture)" in
  arm64)
    case "$OS" in
    Ubuntu)
      sudo apt-get -y install \
        ninja-build gettext libtool \
        libtool-bin autoconf automake \
        cmake g++ pkg-config unzip curl doxygen
      _linux_build
      ;;
    *) echo "Installer for $OS is not prepared yet" return >&2 ;;
    esac
    ;;
  amd64)
    case "$OS" in
    Ubuntu)
      wget https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.deb
      sudo apt-get install -y ./nvim-linux64.deb
      sudo apt-get update && sudo apt-get install -y neovim
      rm ./nvim-linux64.deb
      ;;
    *)
      echo "Installer for $OS is not prepared yet" >&2
      return
      ;;
    esac
    ;;
  *)
    echo "Invalid architecture given" >&2
    ;;
  esac
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
