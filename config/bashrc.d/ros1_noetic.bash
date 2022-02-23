#/usr/bin/env bash

# Terminal for build setup
noetic_devel_setup() {
  export ROS_DISTRO=noetic

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source /opt/ros/$ROS_DISTRO/setup.bash

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;34m\]<$ROS_DISTRO🔧>\e[0m\n$ "

  # Create  directory
  mkdir -p $ros_ws; cd $ros_ws
}

noetic_exec_setup() {
  export ROS_DISTRO=noetic

  ros_ws="$HOME/ws_$ROS_DISTRO"
  source "$ros_ws/devel/setup.bash"

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;95m\]<$ROS_DISTRO🎬>\e[0m\n$ "
}
