#!/usr/bin/env bash

# Terminal for build setup
foxy_devel_setup() {
  export ROS_DISTRO=foxy

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source /opt/ros/$ROS_DISTRO/setup.bash

  # CLI tool setup
  ros2_cli_setup $ros_ws

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;33m\]<$ROS_DISTRO🔧>\e[0m\n$ "

  # Create direcotry
  mkdir -p $ros_ws; cd $ros_ws
}


# Termianl for excution setup
foxy_exec_setup() {
  export ROS_DISTRO=foxy

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source "$ros_ws/install/setup.bash"

  # CLI tool setup
  ros2_cli_setup $ros_ws

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;96m\]<$ROS_DISTRO🎬>\e[0m\n$ "
}