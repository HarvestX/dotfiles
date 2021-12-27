#!/usr/bin/env bash

this_file=$BASH_SOURCE
dist_dir=`dirname $this_file`


if [ -d $dist_dir ]; then
  for rc in $dist_dir/*.bash; do
    [[ $rc == $this_file ]] && continue
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

unset rc
unset modules
unset this_file
