<img src="https://harvestx.jp/img/logo-red.svg" width="30%">


# dotfiles
HarvestX dotfiles for Unix shell

## About
This Repository contains installation script and configurations for essential tools.

## Requirements
- `make`

### Ubuntu
```bash
sudo apt install -y make
```

## Packages
- tmux
- nvim
- fzf
- vimplug
- github-cli

To setup, type
```bash
make deploy
```

## Configuration
To set configuration, type
```bash
make config
```


## Optional Packages
- docker & docker-compose
- ros2 (galactic)
- vscode
- Google Chrome

To install optional packages, type
```bash
make install-optional
```

## SSH server and x11vnc setup
To setup ssh server and x11vnc,
```bash
make config-ssh-server
```
And it will ask
- SSH port to open.
- vnc password.
- x11vnc forwarding port to open.

