.PHONY: config install deploy

all: config install deploy

deploy: install
	gh auth login


# Install standard packages listed below
install: tmux nvim fzf vimplug gh-cli pip-utils

config:
	./config/install.sh

tmux:
	./install/tmux/install.sh

nvim:
	./install/nvim/install.sh

gh-cli:
	./install/gh-cli/install.sh

vimplug:
	./install/vimplug/install.sh

fzf:
	./install/fzf/install.sh

pip-utils:
	./install/pip-utils/install.sh

config-ssh-server:
	./system/setup.sh
	./config/register_sshkey.sh

# Install Optional packages listed below
install-optional: ros2 vscode docker chrome

ros2:
	./install/ros2/install.sh

vscode:
	./install/vscode/install.sh

docker:
	./install/docker/install.sh

chrome:
	./install/chrome/install.sh

# Not Installed by default
openocd:
	./install/openocd/install.sh

