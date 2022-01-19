# dotfiles
HarvestX dotfiles for Unix shell

### About
This Repository contains installation script and configurations for esseintial tools.


## Pasckages
- tmux
- nvim
- github-cli
- vimplug

To setup, type
```bash
make install deploy
```

## Configuration
To set configuration, type
```bash
make config
```


## Optinal Packages (Only supported for Ubuntu 20.04)
- docker & docker-compose
- ros2
- vscode

To install optional packages, type
```bash
make ubuntu-install-optional
```
## SSH server and x11vnc setup
To setup ssh server and x11vnc,
```bash
make ubuntu-config-ssh-server
```
And it will ask vnc password.

