SHELL=/bin/bash
APP_LIST = git curl stow
assert-command-present = $(if $(shell which $1),,$(error '$1' missing and needed for this build))
$(foreach src,$(APP_LIST),$(call assert-command-present,$(src)))

XDG_CACHE_HOME ?= $(HOME)/.cache
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share
UP_TARG_DIR := $(abspath ../)

GIT_USER="$(shell git config --get user.name )"
GIT_REMOTE_ORIGIN_URl="$(shell git config --get remote.origin.url )"
GIT_REPO_FULL_NAME="$(shell echo $(GIT_REMOTE_ORIGIN_URl) | sed -e 's/git@github.com://g' | sed -e 's/\.git//g' )"
GIT_REPO_NAME="$(shell echo $(GIT_REPO_FULL_NAME) |cut -d/ -f2 )"
GIT_REPO_OWNER_LOGIN="$(shell echo $(GIT_REPO_FULL_NAME) |cut -d/ -f1 )"

OS_NAME := $(shell cat /etc/*release | grep -oP '^NAME="\K\w+')
SYSTEMD_PATH := $(shell pgrep -fau $$(whoami) systemd | grep user | cut -d ' ' -f 2)
# BASH_PROFILE=/usr/share/defaults/etc/profile.d
# NOTE: use googles dns nameserver with dig
# dig @8.8.8.8 +short gmack.nz

$(info 'OS NAME: $(OS_NAME) ')

assert-is-root = $(if $(shell id -u | grep -oP '^0$$'),\
 $(info OK! root user, so we can change some system files),\
 $(error changing system files so need to sudo) )

#@stow -v -t ~ bash
#@stow -v -t ~ tmux
#@stow -v -t ~/.config/nvim nvim
#@stow -v -t ~/bin  bin

default: solus-packages

pkg: solus-packages

stow-all:
	@echo 'TASK': use stow to create symlinks in home dir
	$(if $(wildcard  $(HOME)/bin ),,mkdir $(HOME)/bin)
	$(if $(wildcard  $(XDG_CONFIG_HOME)/bash ),,mkdir $(XDG_CONFIG_HOME)/bash)
	@stow -v -t ~ bash

solus-packages: bin/my-solus-packages.list
	@sudo bin/install-solus-packages.sh $<

backup-brashrc:
	@mv $(HOME)/.bashrc $(HOME)/.bashrc-$(date +%F).bk

stow-tmux:
	$(if $(wildcard  $(HOME)/.tmux/plugins ),,git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm)
	@stow -v -t ~ tmux
	$(if $(wildcard  $(HOME)/.tmux/plugins/tmux-sensible),\
 cd $(HOME)/.tmux/plugins/tpm/bin && ./update_plugins all ,\
 cd $(HOME)/.tmux/plugins/tpm/bin && ./install_plugins)

stow-neovim:
	@mkdir -p $(XDG_CACHE_HOME)/nvim
	@mkdir -p $(XDG_CONFIG_HOME)/nvim
	@echo "$(XDG_DATA_HOME)/nvim"
	@ls -al  "$(XDG_DATA_HOME)/nvim/site"
	@ls -al  "nvim/site"
	@[ -L $(XDG_CONFIG_HOME)/nvim/init.vim ] || ln -s -v -t $(XDG_CONFIG_HOME)/nvim "$$(pwd)/nvim/init.vim"
	@cd nvim; stow -v -t "$(XDG_DATA_HOME)/nvim/site" site

stow-node:
	@echo '# $(@) #'
	@ls -al  node_modules/.bin
	@stow -v -t "$(UP_TARG_DIR)/node_modules" node_modules






# @stow -v -t $(XDG_DATA_HOME)/nvim/site nvim/site
# @ln -s -v -t $(XDG_CONFIG_HOME)/nvim nvim/init.config

# $(if $(wildcard  $(HOME).local/share/nvim/site/autoload/plug.vim ),,\
#  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim )

neovimBackspaceFix:
	infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
	tic $TERM.ti

$(HOME).config/seoul256-gnome-terminal:
	git clone https://github.com/anuragsoni/seoul256-gnome-terminal.git $(HOME)/.config/seoul256-gnome-terminal
	source $(HOME)/.config/seoul256-gnome-terminal/seoul256-dark.sh


# https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
# TODO!

pyEnv:
	@echo 'todo'
	curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

caps2esc:
	@echo 'TASK': map esc to capslock

# setup plugin enviroment for neovim
# set up local py enviroment
# to run neovim

define caps2escService
[Unit]
Description=caps2esc

[Service]
ExecStart=/bin/nice -n -20 /home/gmack/bin/caps2esc

[Install]
WantedBy=multi-user.target
endef

capsService: export caps2escService:=$(caps2escService)
capsService:
	@echo "setup caps2Sec under systemd"
	@$(call assert-is-root)
	$(if $(wildcard ../../oblitum/caps2esc/caps2esc), $(info 'good to go') ,$(error 'oh no!'))
	@cp ../../oblitum/caps2esc/caps2esc /home/gmack/bin
	@echo '====================================================================================='
	@echo "$${caps2escService}" >  $(SYSTEMD_PATH)/caps2esc.service
	@cat  /usr/lib/systemd/system/caps2esc.service
	@systemctl enable caps2esc.service
	@systemctl start caps2esc.service
	@journalctl -f -u caps2esc.service -o cat

define myTmuxService
[Unit]
Description=Terminal Multiplexer
Documentation=man:tmux(1)

[Service]
Type=oneshot
RemainAfterExit=yes
Environment=DISPLAY=:0
ExecStart=$(shell which tmux) -2 new-session -d %u
ExecStop=$(shell which tmux) kill-session -t %u

[Install]
WantedBy=default.target
endef

# sudo loginctl enable-linger $(whoami)

tmuxService: export myTmuxService:=$(myTmuxService)
tmuxService:
	@echo "setup tmux under systemd"
	@mkdir -p $(HOME)/.config/systemd/user
	@echo "$${myTmuxService}" > $(HOME)/.config/systemd/user/tmux.service

