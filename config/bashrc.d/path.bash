#!/usr/bin/env bash

THIS_FILE=$BASH_SOURCE
MY_BIN_DIR=`realpath $(dirname $(realpath $THIS_FILE))/../../bin`
if [ -d $MY_BIN_DIR ]; then
  PATH=$MY_BIN_DIR:$PATH
fi

unset THIS_FILE
unset MY_BIN_DIR

