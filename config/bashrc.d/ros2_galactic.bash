#!/usr/bin/env bash

# Terminal for build setup
galactic_devel_setup() {
  export ROS_DISTRO=galactic

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source /opt/ros/$ROS_DISTRO/setup.bash

  # CLI tool setup
  ros2_cli_setup $ros_ws

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;34m\]<$ROS_DISTRO🔧>\e[0m\n$ "

  # Create direcotry
  mkdir -p $ros_ws; cd $ros_ws
}


# Termianl for excution setup
galactic_exec_setup() {
  export ROS_DISTRO=galactic

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source "$ros_ws/install/setup.bash"

  # CLI tool setup
  ros2_cli_setup $ros_ws

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;97m\]<$ROS_DISTRO🎬>\e[0m\n$ "

  # Create directory
  mkdir -p $ros_ws/src; cd $ros_ws/src
}

# Open tmux panes
galactic_open() {
  local ROS_DISTRO="galactic"
  local session_name="${ROS_DISTRO}_ide"
  tmux new-session -s $session_name  \; \
    split-window -v \; \
    select-pane -t 0 \; \
    send-keys -t 0 "${ROS_DISTRO}_devel_setup" C-m \; \
    send-keys -t 1 "${ROS_DISTRO}_exec_setup" C-m \;
}

# Close tmux panes
galactic_close() {
  local ROS_DISTRO="galactic"
  local session_name="${ROS_DISTRO}_ide"
  tmux kill-session -t $session_name
}

