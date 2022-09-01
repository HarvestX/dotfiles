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
      echo "Please type valid port number." >&2
      continue
    fi
    if ! $(is_valid_port_range $REPLY); then
      echo "Given port $1 is out of available port range [0-65535]." >&2
      continue
    fi
    if ! $(is_available_port $REPLY); then
      echo "Given port $1 is already in use." >&2
      continue
    fi
    # Here finally the number is valid
    echo $REPLY
    break
  done
}

_linux_setup() {
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
  elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
  elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
  else
    echo "Can not detect destribution" >&2
  fi

  case "$OS" in
  Ubuntu)
    ## setup
    sudo apt-get install -y openssh-server x11vnc xvfb jq
    ssh_port=$(ask_port SSH_PORT)
    sudo cp -f $THIS_DIR/sshd_config /etc/ssh/sshd_config
    sudo sed -i "s/#Port 22/Port $ssh_port/g" /etc/ssh/sshd_config
    sudo service ssh restart
    sudo x11vnc -storepasswd /etc/.vncpasswd
    sudo cp -f $THIS_DIR/x11vnc.service /etc/systemd/system/x11vnc.service
    vnc_port=$(ask_port X11VNC_PORT)
    sudo sed -i "s/<PORT_PLACEHOLDER>/$vnc_port/g" /etc/systemd/system/x11vnc.service
    sudo systemctl enable x11vnc.service
    sudo systemctl start x11vnc.service

    unset ssh_port
    unset vnc_port

    unset THIS_FILE
    unset THIS_DIR
    ;;
  *)
    echo "Installer for $OS is not prepared yet" >&2
    return
    ;;
  esac
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_setup ;;
Linux\ *64) _linux_setup ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
