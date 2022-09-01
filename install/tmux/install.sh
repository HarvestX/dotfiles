#!/usr/bin/env bash

set eu
cd $(dirname $0)

_linux_install() {
  mkdir -p $HOME/.local/bin
  wget https://github.com/m12watanabe1a/tmux-static-build/raw/"$(dpkg --print-architecture)"/tmux -P $HOME/.local/bin
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
