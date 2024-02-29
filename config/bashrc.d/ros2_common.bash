#!/usr/bin/env bash

colbuil() {
  colcon build --cmake-args '-DCMAKE_BUILD_TYPE=Release' $@
}

colclean() {
  rm -r log install build
}

ccolbuil() {
  colbuil --cmake-clean-first $@
}

colcheck() {
  local pkg=$1
  colcon build --packages-up-to $pkg
  colcon test --packages-select $pkg
  colcon test-result --verbose
}

ros2_cli_setup() {
  # Command
  local ros_ws=$1
  export _colcon_cd_root="$ros_ws"
  export RCUTILS_COLORIZED_OUTPUT=1
}
