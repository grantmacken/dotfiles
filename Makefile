SHELL=/bin/bash
include projects/properties/common.properties
WEB_PROJECTS := gmack.nz zie.nz markup.nz
APP_LIST = git curl stow
assert-command-present = $(if $(shell which $1),,$(error '$1' missing and needed for this build))
$(foreach src,$(APP_LIST),$(call assert-command-present,$(src)))

XDG_CACHE_HOME ?= $(HOME)/.cache
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_BIN ?= $(HOME)/.local/bin
UP_TARG_DIR := $(abspath ../)

GIT_USER=$(shell git config user.name )
GIT_REMOTE_ORIGIN_URl=$(shell git config --get remote.origin.url )
GIT_REPO_FULL_NAME=$(shell echo $(GIT_REMOTE_ORIGIN_URl) | sed -e 's/git@github.com://g' | sed -e 's/\.git//g' )
GIT_REPO_NAME=$(shell echo $(GIT_REPO_FULL_NAME) |cut -d/ -f2 )
GIT_REPO_OWNER_LOGIN=$(shell echo $(GIT_REPO_FULL_NAME) |cut -d/ -f1 )

OS_NAME := $(shell cat /etc/*release | grep -oP '^NAME="\K\w+')
SYSTEMD_PATH := $(shell pgrep -fau $$(whoami) systemd | grep user | cut -d ' ' -f 2)
# BASH_PROFILE=/usr/share/defaults/etc/profile.d
# NOTE: use googles dns nameserver with dig
# dig @8.8.8.8 +short gmack.nz

# $(info 'OS NAME: $(OS_NAME) ')
# A literal space.
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

assert-is-root = $(if $(shell id -u | grep -oP '^0$$'),\
 $(info OK! root user, so we can change some system files),\
 $(error changing system files so need to sudo) )

define mkHelp
=========================================================

 `make help`     this
 `make {target}` will use stow to create symlinks
 `make {target}-clean` will use stow to remove symlinks

TARGETS: [ neovim | home | projects ]

UP DIR: $(UP_TARG_DIR)

Use config to list web project domains

=========================================================
endef

.PHONY: neovim home projects

default: help

help: export mkHelp:=$(mkHelp)
help:
	@echo "$${mkHelp}"
	@echo ""
	@echo 'WEB PROJECTS'
	@echo '------------'
	@$(foreach project,$(WEB_PROJECTS),echo $(UP_TARG_DIR)/$(project);)

neovim:
	@mkdir -p $(XDG_CACHE_HOME)/nvim
	@mkdir -p $(XDG_CONFIG_HOME)/nvim
	@mkdir -p $(XDG_DATA_HOME)/nvim/site/autoload
	@mkdir -p $(XDG_DATA_HOME)/nvim/site/plugged
	$(if $(wildcard  $(XDG_DATA_HOME)/nvim/site/autoload/plug.vim ),,\
 $(shell curl -fLo $(XDG_DATA_HOME)/nvim/site/autoload/plug.vim  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim))
	@[ -L $(XDG_CONFIG_HOME)/nvim/init.vim ]  && >/dev/null || \
 ln -s -v -t $(XDG_CONFIG_HOME)/nvim "$$(pwd)/nvim/init.vim"
	@cd nvim; stow -v -t "$(XDG_DATA_HOME)/nvim/site" site
	@#cd nvim; stow -D -v -t "../../eXistResty/nvim/site" site

neovim-clean:
	@echo 'Task: $(notdir $@)'
	@[ -L $(XDG_CONFIG_HOME)/nvim/init.vim ] && rm -v $(XDG_CONFIG_HOME)/nvim/init.vim || >/dev/null
	@cd nvim; stow -D -v -t "$(XDG_DATA_HOME)/nvim/site" site

X-neovim-update:
	@cd $(HOME)/apps; curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
	@chmod u+x $(HOME)/apps/nvim.appimage
	@[ -L $(HOME)/bin/nvim  ]  && echo -n || \
 ln -s -v -T $(HOME)/apps/nvim.appimage $(HOME)/bin/nvim 
	@cd $(HOME)/apps;ls

neovim-clients:
	@node install -g neovim

#@pip install --user -U neovim
#@gem --user-install neovim
#@gf ~/.local/bin

.PHONY: bin
bin:
	@echo 'TASK: use stow to create symlinks in ~/.local/bin dir'
	@stow -v -t ~/.local/bin bin

.PHONY: bin
clean-bin:
	@echo 'TASK: use stow to remove symlinks in home bin dir '
	@stow -D -v -t ~/bin bin

.PHONY: bash
bash:
	@echo 'TASK: use stow to create bash symlinks in home dir'
	$(if $(wildcard  $(XDG_CONFIG_HOME)/bash ),,mkdir -p $(XDG_CONFIG_HOME)/bash)
	@stow -v -t ~ bash

.PHONY: clean-bash
clean-bash:
	@echo 'TASK : use stow to remove bash symlinks in home dir'
	@stow -D -v -t ~ bash

.PHONY: configs
configs:
	@echo 'TASK: use stow to create symlinks in home/.config dir'
	@stow -v -t ~/.config configs
	@#systemctl --user daemon-reload

.PHONY: clean-configs
clean-configs:
	@echo 'TASK: use stow to remove symlinks in home/.config dir'
	@stow -D -v -t ~/.config configs

ROCKS = luv mpack lua-cjson2 xmlua formatter checks
ROCKS_REG_LIST = $(subst $(SPACE),|,$(ROCKS))
outdatedRocks != luarocks list --outdated | grep -oP '^($(ROCKS_REG_LIST))'

luarocks:
	@echo '# $(@) #'
	@echo '$(ROCKS)'
	@$(foreach rock,$(ROCKS), luarocks show '$(rock)' | grep -q -oP '^$(rock)' && \
 luarocks show $(rock) || \
 luarocks install --local $(rock);)
	@$(foreach rock,$(outdatedRocks), luarocks install --local '$(rock)';)
	@[ -L /usr/local/openresty/luajit/lib/lua/5.1/luv.so ]  && echo -n || \
 ln -s -v -T $(HOME)/.luarocks/lib/lua/5.1/luv.so  /usr/local/openresty/luajit/lib/lua/5.1/luv.so
	@cd $(HOME)/.luarocks; stow -v -t "$(UP_TARG_DIR)/bin" bin

projects-node:
	@echo '# $(@) #'
	@echo UP DIR: $(UP_TARG_DIR)
	$(if $(wildcard  $(UP_TARG_DIR)/node_modules/.bin ),,$(shell mkdir $(UP_TARG_DIR)/node_modules/.bin))
	@cd projects; stow -v -t "$(UP_TARG_DIR)" node

projects-node-clean:
	@echo '# $(@) #'
	@cd projects; stow -D -v -t "$(UP_TARG_DIR)" node

# properties files are used by execs in project bin so include here

projects-bin:
	@echo '# $(@) #'
	@echo 'TASK : my current projects bin'
	$(if $(wildcard  $(UP_TARG_DIR)/bin ),,$(shell mkdir $(UP_TARG_DIR)/bin))
	@cd projects; stow -v -t "$(UP_TARG_DIR)" properties
	@cd projects; stow -v -t "$(UP_TARG_DIR)/bin" bin

projects-bin-clean:
	@echo '# $(@) #'
	@cd projects; stow -D -v -t "$(UP_TARG_DIR)" properties
	@cd projects; stow -D -v -t "$(UP_TARG_DIR)/bin" bin

projects-tasks:
	@echo '# $(@) #'
	@$(foreach project,$(WEB_PROJECTS),$(shell cd projects && stow -v -t $(UP_TARG_DIR)/$(project) tasks))

projects-tasks-clean:
	@echo '# $(@) #'
	@$(foreach project,$(WEB_PROJECTS),$(shell cd projects && stow -D -v -t $(UP_TARG_DIR)/$(project) tasks))

projects:
	@echo '# $(@) #'
	@$(MAKE) projects-bin projects-node projects-tasks

projects-clean:
	@echo '# $(@) #'
	@$(MAKE) projects-tasks-clean projects-bin-clean projects-node-clean

pkg: solus-packages

solus-packages: bin/my-solus-packages.list
	@sudo bin/install-solus-packages.sh $<

backup-brashrc:
	@mv $(HOME)/.bashrc $(HOME)/.bashrc-$(date +%F).bk

neovimBackspaceFix:
	infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
	tic $TERM.ti

$(HOME).config/seoul256-gnome-terminal:
	git clone https://github.com/anuragsoni/seoul256-gnome-terminal.git $(HOME)/.config/seoul256-gnome-terminal
	source $(HOME)/.config/seoul256-gnome-terminal/seoul256-dark.sh


pyEnv:
	@echo 'todo'
	curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

caps2esc:
	@echo 'TASK': map esc to capslock

# setup plugin enviroment for neovim
# set up local py enviroment
# to run neovim


############
# TMUX
############ 

.PHONY: stow-tmux
stow-tmux:
	$(if $(wildcard  $(HOME)/.tmux/plugins ),,git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm)
	@stow -v -t ~ tmux
	$(if $(wildcard  $(HOME)/.tmux/plugins/tmux-sensible),\
 cd $(HOME)/.tmux/plugins/tpm/bin && ./update_plugins all ,\
 cd $(HOME)/.tmux/plugins/tpm/bin && ./install_plugins)

define myTmuxService
[Unit]
Description=Terminal Multiplexer
Documentation=man:tmux(1)

[Service]
Type=oneshot
RemainAfterExit=yes
Environment=DISPLAY=:0
ExecStart=$(shell which tmux) new-session -d -s $(GIT_USER)
ExecStop=$(shell which tmux) kill-server
WorkingDirectory=$(HOME)/projects/$(GIT_USER)
KillMode=none

[Install]
WantedBy=graphical.target
endef

.PHONY: tmux
tmux: /home/gmack/.config/systemd/user/tmux.service
	@systemctl --no-pager --user enable tmux.service
	@systemctl --no-pager --user start tmux.service
	@systemctl --no-pager --user status tmux.service
	@tmux ls

.PHONY: clean-tmux
clean-tmux:
	@rm  -f $(HOME).config/systemd/user/tmux.service

.PHONY: clean-tmux
clean-tmux:
	@systemctl --no-pager --user status tmux.service

/home/gmack/.config/systemd/user/tmux.service: export myTmuxService:=$(myTmuxService)
/home/gmack/.config/systemd/user/tmux.service: clean-tmux
	@echo "$$myTmuxService" > $@

define myDockerService
[Unit]
Description=Docker Compose Up
# Requires=docker.service
# After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=%h/projects/$(GIT_USER)/dorex
ExecStart=docker-compose up -d
ExecStop=docker-compose down
KillMode=none

[Install]
WantedBy=graphical.target
endef


