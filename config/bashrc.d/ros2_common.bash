#!/usr/bin/env bash

colbuil() {
  colcon build --cmake-args '-DCMAKE_BUILD_TYPE=Release' --symlink-install $@
}

colclean() {
  rm -r log install build
}

ccolbuil() {
  colcon build --cmake-clean-first --cmake-args '-DCMAKE_BUILD_TYPE=Release' --symlink-install $@
}

ros2_cli_setup() {
  # Command
  local ros_ws=$1
  source /usr/share/colcon_cd/function/colcon_cd.sh
  source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
  source /usr/share/vcstool-completion/vcs.bash
  export _colcon_cd_root="$ros_ws"
  export RCUTILS_COLORIZED_OUTPUT=1
}
