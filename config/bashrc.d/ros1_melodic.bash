#/usr/bin/env bash

# Terminal for build setup
melodic_devel_setup() {
  export ROS_DISTRO=melodic

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source /opt/ros/$ROS_DISTRO/setup.bash

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;34m\]<$ROS_DISTRO🔧>\e[0m\n$ "

  # Create  directory
  mkdir -p $ros_ws; cd $ros_ws
}

melodic_exec_setup() {
  export ROS_DISTRO=melodic

  ros_ws="$HOME/ws_$ROS_DISTRO"
  source "$ros_ws/devel/setup.bash"

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;95m\]<$ROS_DISTRO🎬>\e[0m\n$ "
}