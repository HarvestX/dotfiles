#/usr/bin/env bash

# Terminal for build setup
melodic_devel_setup() {
  export ROS_DISTRO=melodic

  local ros_ws="$HOME/ws_$ROS_DISTRO"
  source /opt/ros/$ROS_DISTRO/setup.bash

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;34m\]<$ROS_DISTRO🔧>\e[0m\n$ "

  # Create  directory
  mkdir -p $ros_ws
  cd $ros_ws
}

# Termianl for excution setup
melodic_exec_setup() {
  export ROS_DISTRO=melodic

  ros_ws="$HOME/ws_$ROS_DISTRO"
  source "$ros_ws/devel/setup.bash"

  # Update Prompt
  PS1="\e[1;92m\u@\h\e[0m \[\e[93m\]\w\[\e[91m\]\$(__git_ps1)\[\e[0m \e[1;95m\]<$ROS_DISTRO🎬>\e[0m\n$ "

  # Create directory
  mkdir -p $ros_ws/src
  cd $ros_ws/src
}

# Open tmux panes
melodic_open() {
  local ROS_DISTRO="melodic"
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
melodic_close() {
  local ROS_DISTRO="melodic"
  local session_name="${ROS_DISTRO}_ide"
  tmux kill-session -t $session_name
}
