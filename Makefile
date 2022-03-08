.PHONY: config deploy vimplug fzf ubuntu-setup

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BIN_DIR = $(ROOT_DIR)/bin

TMUX_DIR = ./install/tmux
NVIM_DIR = ./install/nvim
GITHUB_CLI_DIR = ./install/gh-cli

all: config install deploy

deploy: install
	mkdir -p $(BIN_DIR)
	cp $(TMUX_DIR)/temp/tmux $(BIN_DIR)/tmux
	cp $(NVIM_DIR)/temp/nvim $(BIN_DIR)/nvim
	cp $(GITHUB_CLI_DIR)/temp/build/gh $(BIN_DIR)/gh
	$(BIN_DIR)/gh auth login
	$(shell exec -l $SHELL)

install: tmux nvim fzf vimplug github-cli

config:
	./config/install.sh

tmux:
	$(TMUX_DIR)/install.sh

nvim:
	$(NVIM_DIR)/install.sh

github-cli:
	$(GITHUB_CLI_DIR)/install.sh

vimplug:
	./install/vimplug/install.sh

fzf:
	./install/fzf/install.sh

ubuntu-config-ssh-server: ubuntu-setup
	./system/setup.sh
	./config/register_sshkey.sh

ubuntu-install-optional: ubuntu-ros2 ubuntu-vscode ubuntu-docker ubuntu-openocd
	sudo apt install -y xsel

ubuntu-ros2:
	./install/ros2/install_galactic.sh

ubuntu-vscode:
	./install/vscode/install.sh

ubuntu-docker:
	./install/docker/install.sh

ubuntu-openocd:
	./install/openocd/install.sh

