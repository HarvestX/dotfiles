#!/usr/bin/env bash

set eu
cd $(dirname $0)

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
    if [[ $(uname -r) =~ WSL ]]; then
      echo "WSL detected. Skip installation..." >&2
      return
    fi

    # Install VSCode
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo bash -c 'echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" >/etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code
    ;;
  *)
    echo "Installer for $OS is not prepared yet" >&2
    return
    ;;
  esac

  # Install VSCode Extensions
  code --install-extension ms-vscode.cpptools                    # Cpp syntax
  code --install-extension zachflower.uncrustify                 # Cpp formatter
  code --install-extension redhat.vscode-xml                     # XML formatter
  code --install-extension eamodio.gitlens                       # Git Lens
  code --install-extension twxs.cmake                            # CMake syntax
  code --install-extension cheshirekow.cmake-format              # Cmake formatter
  code --install-extension streetsidesoftware.code-spell-checker # English spell checker
  code --install-extension shardulm94.trailing-spaces            # Whitespace visualiz A
  code --install-extension Gruntfuggly.todo-tree                 # Annotation comment checker
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) echo "Invalid architecture given: $archi" >&2 ;;
esac
