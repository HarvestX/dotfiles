#!/usr/bin/env bash

#!/bin/bash
set eu
cd `dirname $0`

TMUX_VERSION="3.2a"
LIBEVENT_VERSION="2.1.11"
NCURSES_VERSION="6.2"


[ -e temp ] && rm -rf temp

mkdir temp
cd temp
wget https://github.com/Tagussan/tmux-static-build/raw/main/tmux
chmod u+x tmux
