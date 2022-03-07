# dotfiles
HarvestX dotfiles for Unix shell

## About
This Repository contains installation script and configurations for esseintial tools.


## Pasckages
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


## Optinal Packages (Ubuntu 20.04)
- docker & docker-compose
- ros2
- vscode
- openocd

To install optional packages, type
```bash
make ubuntu-install-optional
```
## SSH server and x11vnc setup (Ubuntu 20.04)
To setup ssh server and x11vnc,
```bash
make ubuntu-config-ssh-server
```
And it will ask
- SSH port to open.
- vnc password.
- x11vnc forwarding port to open.

