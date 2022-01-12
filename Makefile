.PHONY: config deploy vimplug fzf ubuntu-setup

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BIN_DIR = $(ROOT_DIR)/bin

TMUX_DIR = ./install/tmux
NVIM_DIR = ./install/nvim

all: config install deploy

deploy: tmux nvim
	mkdir -p $(BIN_DIR)
	cp $(TMUX_DIR)/temp/tmux $(BIN_DIR)/tmux
	cp $(NVIM_DIR)/temp/nvim $(BIN_DIR)/nvim

install: tmux nvim fzf vimplug

config:
	./config/install.sh

tmux:
	$(TMUX_DIR)/install.sh

nvim:
	$(NVIM_DIR)/install.sh

vimplug:
	./install/vimplug/install.sh

fzf:
	./install/fzf/install.sh

ubuntu-setup:
	sudo apt update
	sudo apt install -y xsel
