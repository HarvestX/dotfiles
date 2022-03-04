#!/usr/bin/env bash

THIS_FILE=$BASH_SOURCE
THIS_DIR=$(dirname $THIS_FILE)

is_available_port() {
  local res=$(netstat -ano | grep -c ":$1")
  if (($res)); then
    false
  else
    true
  fi
}

is_valid_number() {
  local val=$1
  if [[ $val =~ ^[\-0-9]+$ ]]; then
    true
  else
    false
  fi
}

is_valid_port_range() {
  local val=$1
  if (($val > 0)) && (($val <= 65535)); then
    true
  else
    false
  fi
}

ask_port() {
  # ask_port <target_name>
  while true; do
    read -p "Type $1: " -r
    if ! $(is_valid_number $REPLY); then
      printf "Please type valid port number.\n"
      continue
    fi
    if ! $(is_valid_port_range $REPLY); then
      printf "Given port $1 is out of available port range [0-65535].\n"
      continue
    fi
    if ! $(is_available_port $REPLY); then
      printf "Given port $1 is already in use.\n"
      continue
    fi
    # Here finally the number is valid
    echo $REPLY
    break
  done
}

## setup
sudo apt install -y openssh-server x11vnc xvfb jq
ssh_port=$(ask_port SSH_PORT)
sudo sed -i "s/#Port 22/Port $ssh_port/g" /etc/ssh/sshd_config
sudo service ssh restart
sudo x11vnc -storepasswd /etc/.vncpasswd
sudo cp $THIS_DIR/x11vnc.service /etc/systemd/system/x11vnc.service
vnc_port=$(ask_port X11VNC_PORT)
sudo sed -i "s/<PORT_PLACEHOLDER>/$vnc_port/g" /etc/systemd/system/x11vnc.service
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service

unset ssh_port
unset vnc_port

unset THIS_FILE
unset THIS_DIR
