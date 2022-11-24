#!/usr/bin/env bash

set eu
cd $(dirname $0)

_linux_install() {
  destination=$HOME/.local/bin
  mkdir -p $HOME/.local/bin
  if [[ ! -x $HOME/.local/bin/tmux ]]; then
    wget https://github.com/m12watanabe1a/tmux-static-build/raw/"$(dpkg --print-architecture)"/tmux -P $destination
    chmod +x $destination/tmux
  else
    echo "Tmux already installed" >&2
    return
  fi

  case "$OS" in
  Ubuntu)
    sudo apt-get install -y ncurses-term
    ;;
  esac
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
