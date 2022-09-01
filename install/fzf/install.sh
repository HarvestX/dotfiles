#!/usr/bin/env bash

set eu
cd $(dirname $0)

_linux_install() {
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.config/fzf
  $HOME/.config/fzf/install --xdg --bin --key-bindings --completion
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
