#!/usr/bin/env bash

set eu
cd $(dirname $0)

COMPOSE_VERSION=2.10.2

_linux_install() {
  # Block installation for jetson
  case "$(uname -r)" in
  *tegra)
    echo "Official Docker installation not recommended jetson..." >&2
    echo "Skip instalation..." >&2
    return
    ;;
  *) ;;
  esac

  # Install Docker
  curl https://get.docker.com | sh &&
    sudo systemctl --now enable docker
  sudo usermod -aG docker $USER
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) printf "Invalid architecture given: $archi" ;;
esac
