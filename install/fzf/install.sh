#!/usr/bin/env bash

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.config/fzf
$HOME/.config/fzf/install --xdg --bin --key-bindings --completion

