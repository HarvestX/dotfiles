#!/usr/bin/env bash

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

if [ -z $PS_COLOR ]; then
  PS_COLOR=92m
fi

PS1="\e[1;$PS_COLOR\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[00m\]\n$ "
