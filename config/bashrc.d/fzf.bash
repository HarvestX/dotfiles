#!/usr/bin/env bash

# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.config/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.config/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/fzf/shell/key-bindings.bash"
