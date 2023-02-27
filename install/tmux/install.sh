#!/usr/bin/env bash

set eu
cd $(dirname $0)

_get_static_built_binary() {
  destination=$HOME/.local/bin
  mkdir -p $HOME/.local/bin
  if [[ ! -x $HOME/.local/bin/tmux ]]; then
    wget https://github.com/m12watanabe1a/tmux-static-build/raw/"$(dpkg --print-architecture)"/tmux -P $destination
    chmod +x $destination/tmux
  else
    echo "Tmux already installed" >&2
    return
  fi
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

  case "$OS" in
  Ubuntu)
    case "$VER" in
    20.04)
      _get_static_built_binary
      sudo apt-get install -y ncurses-term
      ;;
    22.04)
      sudo apt-get install -y tmux ncurses-term
      ;;
    esac
    ;;
  *)
    echo "Installer for $OS is not prepared yet" >&2
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
