#!/usr/bin/env bash

# Terminal for build setup
humble_devel_setup() {
  export ROS_DISTRO="humble"

  local ws_name
  case $# in
  0)
    ws_name=$ROS_DISTRO
    ;;
  1)
    ws_name=$1
    ;;
  *)
    echo "Invalid number of argument given." >&2
    return
    ;;
  esac

  local ros_ws="$HOME/ws_$ws_name"
  source /opt/ros/$ROS_DISTRO/setup.bash

  # CLI tool setup
  ros2_cli_setup $ros_ws

  # Update Prompt
  if [[ $PS1 != *"$ROS_DISTRO"* ]]; then
    PS1=${PS1::-4}" \e[1;33m\]<$ROS_DISTRO🔧>\e[0m\n$ "
  fi

  # Create direcotry
  mkdir -p $ros_ws
  cd $ros_ws
}

# Termianl for excution setup
humble_exec_setup() {
  export ROS_DISTRO="humble"

  local ws_name
  case $# in
  0)
    ws_name=$ROS_DISTRO
    ;;
  1)
    ws_name=$1
    ;;
  *)
    echo "Invalid number of argument given." >&2
    return
    ;;
  esac

  local ros_ws="$HOME/ws_$ws_name"
  source "$ros_ws/install/setup.bash"

  # CLI tool setup
  ros2_cli_setup $ros_ws

  # Update Prompt
  if [[ $PS1 != *"$ROS_DISTRO"* ]]; then
    PS1=${PS1::-4}" \e[1;96m\]<$ROS_DISTRO🎬>\e[0m\n$ "
  fi

  # Create directory
  mkdir -p $ros_ws/src
  cd $ros_ws/src
}

# Open tmux panes
humble_open() {
  local ROS_DISTRO="humble"
  local session_name="${ROS_DISTRO}_ide"

  local ws_name
  case $# in
  0)
    ws_name=$ROS_DISTRO
    ;;
  1)
    ws_name=$1
    ;;
  *)
    echo "Invalid number of argument given." >&2
    return
    ;;
  esac

  tmux has-session -t $session_name 2>/dev/null

  if [ $? != 0 ]; then
    tmux new-session -s $session_name \; \
      split-window -v \; \
      select-pane -t 0 \; \
      send-keys -t 0 "${ROS_DISTRO}_devel_setup $ws_name" C-m \; \
      send-keys -t 1 "${ROS_DISTRO}_exec_setup $ws_name" C-m \;
  else
    tmux attach -t $session_name
  fi
}

# Close tmux panes
humble_close() {
  local ROS_DISTRO="humble"
  local session_name="${ROS_DISTRO}_ide"
  tmux kill-session -t $session_name
}
