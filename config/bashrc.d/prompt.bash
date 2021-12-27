#!/usr/bin/env bash

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[00m\]\n$ "

