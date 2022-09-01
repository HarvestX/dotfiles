#!/usr/bin/env bash

set eu
cd $(dirname $0)

_linux_install() {
  case "${1}" in
  arm64)
    echo "${1} is not supported."
    return >&2
    ;;
  amd64)
    # Keep process going
    ;;
  *)
    echo "Invalid architecure given: ${1}"
    return >&2
    ;;
  esac

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

  case "$OS" in
  Ubuntu)
    sudo bash -c 'echo "deb [arch=${1}] http://dl.google.com/linux/chrome/deb/ stable main" >>/etc/apt/sources.list.d/google-chrome.list'
    sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo apt-get update && sudo apt-get install -y google-chrome-stable
    ;;
  *)
    echo "Installer for $OS is not prepared yet" >&2
    return
    ;;
  esac
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install $(dpkg --print-architecture) ;;
Linux\ *64) _linux_install $(dpkg --print-architecture) ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
