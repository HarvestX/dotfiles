#!/usr/bin/env bash

# start vnc server
vnc_start () {
  x11vnc -usepw -forever  -shared -xkb -bg -create
}
