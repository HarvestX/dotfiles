.PHONY: config

bin_dir = $(HOME)/.local/bin

install: tmux nvim fzf vimplug

config:
	./config/install.sh


tmux_dir = ./install/tmux
$(tmux_dir)/temp/tmux:
	$(tmux_dir)/install.sh

tmux: $(tmux_dir)/temp/tmux
	cp $(tmux_dir)/temp/tmux $(bin_dir)/tmux

nvim_dir = ./install/nvim
$(nvim_dir)/temp/nvim:
	$(nvim_dir)/install.sh

nvim: $(nvim_dir)/temp/nvim
	cp $(nvim_dir)/temp/nvim $(bin_dir)/nvim

vimplug:
	./install/vimplug/install.sh

fzf:
	./install/fzf/install.sh

