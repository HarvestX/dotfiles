#!/usr/bin/env bash

set eu
cd $(dirname $0)

_install_ubuntu20() {
  ROS_DISTRO="${1}"
  sudo apt-get update && sudo apt-get install -y \
    ros-${ROS_DISTRO}-desktop \
    python3-rosdep \
    ros-dev-tools

  sudo apt-get update && sudo apt-get install -y \
    build-essential \
    cmake \
    git \
    libbullet-dev \
    python3-colcon-common-extensions \
    python3-flake8 \
    python3-pip

  python3 -m pip install flake8

  sudo apt-get update && sudo apt-get install -y \
    python3-pytest-cov \
    python3-rosdep \
    python3-setuptools \
    python3-vcstool \
    wget

  python3 -m pip install -U \
    argcomplete \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-docstrings \
    flake8-import-order \
    flake8-quotes \
    pytest-repeat \
    pytest-rerunfailures \
    pytest

  sudo apt-get install --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev

  sudo apt-get install --no-install-recommends -y \
    libcunit1-dev
}

_install_ubuntu22() {
  ROS_DISTRO="${1}"

  sudo apt-get update && sudo apt-get install -y \
    ros-${ROS_DISTRO}-desktop \
    python3-rosdep \
    ros-dev-tools

  sudo apt update && sudo apt install -y \
    python3-flake8-docstrings \
    python3-pip \
    python3-pytest-cov \
    ros-dev-tools
}

_install_ubuntu() {
  ROS_DISTRO="${1}"

  sudo apt-get update && sudo apt-get install -y curl gnupg2 lsb-release
  sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list >/dev/null

  case "$ROS_DISTRO" in
  foxy)
    echo "Install $ROS_DISTRO"
    ;&
  galactic)
    _install_ubuntu20 $ROS_DISTRO
    ;;
  humble)
    _install_ubuntu22 $ROS_DISTRO
    ;;
  esac

  sudo rosdep init
  rosdep update
}

_linux_install() {
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
    return
  fi

  case "$OS" in
  Ubuntu)
    case "$VER" in
    20.04)
      # _install_ubuntu foxy
      _install_ubuntu galactic
      ;;
    22.04)
      _install_ubuntu humble
      ;;
    esac
    ;;
  *)
    echo "Installer for $OS is not prepared yet" >&2
    return
    ;;
  esac
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
