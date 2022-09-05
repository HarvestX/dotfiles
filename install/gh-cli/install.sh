#!/usr/bin/env bash

set eu
cd $(dirname $0)

GH_VERSION="2.14.7"

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
    echo "Can not detect destribution\n" >&2
    return
  fi

  case "$OS" in
  Ubuntu)
    wget "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_$(dpkg --print-architecture).deb"
    sudo apt install -y "./gh_${GH_VERSION}_linux_$(dpkg --print-architecture).deb"
    rm "./gh_${GH_VERSION}_linux_$(dpkg --print-architecture)".deb
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
