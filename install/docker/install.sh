#!/usr/bin/env bash

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

  # Install Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

archi=$(uname -sm)
case "$archi" in
Linux\ aarch64*) _linux_install ;;
Linux\ *64) _linux_install ;;
*) printf "Invalid architecture given: $archi" ;;
esac
