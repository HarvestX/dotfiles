#!/usr/bin/env bash

set eu
cd $(dirname $0)

COMPOSE_VERSION=2.10.2

_linux_install() {
  # Block installation for jetson
  case "$(uname -r)" in
  *tegra)
    echo "Official Docker installation not recommended jetson..." >&2
    echo "Skip instalation..." >&2
    return
    ;;
  *) ;;
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
    sudo apt-get install -y curl
    ;;
  *)
    echo "Installer for $OS is not prepared yet" >&2
    return
    ;;
  esac

  # Install Docker
  curl https://get.docker.com | sh &&
    sudo systemctl --now enable docker
  sudo usermod -aG docker $USER
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) printf "Invalid architecture given: $archi" ;;
esac
