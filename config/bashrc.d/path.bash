#!/usr/bin/env bash

THIS_FILE=$BASH_SOURCE
MY_BIN_DIR=${HOME}/.local/bin
if [ -d $MY_BIN_DIR ]; then
  PATH=$MY_BIN_DIR:$PATH
fi

unset THIS_FILE
unset MY_BIN_DIR
