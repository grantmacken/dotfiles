SHELL=/usr/bin/bash
.SHELLFLAGS := -euo pipefail -c
# -e Exit immediately if a pipeline fails
# -u Error if there are unset variables and parameters
# -o option-name Set the option corresponding to option-name
.ONESHELL:
.DELETE_ON_ERROR:
.SECONDARY:

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

CONFIG_HOME := $(HOME)/.config
CACHE_HOME  := $(HOME)/.cache
DATA_HOME   := $(HOME)/.local/share
STATE_HOME  := $(HOME)/.local/state
BIN_HOME    := $(HOME)/.local/bin
QUADLET := $(CONFIG_HOME)/containers/systemd
SYSTEMD := $(CONFIG_HOME)/systemd/user
PROJECTS := $(HOME)/Projects

CONTAINER_NAME=zie-toolbox
IMAGE=ghcr.io/grantmacken/$(CONTAINER_NAME)
include .env

.PHONY: help mini

default: delete ## stow dotfiles
	echo '##[ stow dotfiles ]##'
	chmod +x dot-local/bin/*
	stow --verbose --dotfiles --target ~/ .
	echo ' - task completed'

kitty:
	# used for rmpc
	ln -sf $(HOME)/kitty.app/bin/kitty $(HOME)/.local/kitty.app/bin/kitten $(BIN_HOME)/
	cp $(HOME)/.local/kitty.app/share/applications/kitty.desktop $(DATA_HOME)/applications/
	#Update the paths to the kitty and its icon in the kitty desktop file(s)
	sed -i "s|Icon=kitty|Icon=$$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" $(DATA_HOME)/applications/kitty*.desktop
	sed -i "s|Exec=kitty|Exec=$$(readlink -f ~)/.local/kitty.app/bin/kitty|g" $(DATA_HOME)/applications/kitty*.desktop

silverblue:
	ostree-install mpd

gcloud:
	cd ~/Downloads
	curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz

nurr: latest/parsers.json latest/plugins.json

latest/plugins.json: 
	echo '##[ $@ ]##'
	mkdir -p $(dir $@)
	URL=https://raw.githubusercontent.com/nvim-neorocks/nurr/refs/heads/main/plugins.json
	wget -q -nc $${URL} --output-document $@

latest/parsers.json:
	echo '##[ $@ ]##'
	mkdir -p $(dir $@)
	wget -q -nc https://raw.githubusercontent.com/nvim-neorocks/nurr/refs/heads/main/tree-sitter-parsers.json -O $@

# parsers:
# 	echo '##[ $@ ]##'
# 	# cp $(DATA_HOME)/nvim/rocks/lib/lua/5.1/parser/* $(CONFIG_HOME)/nvim/parser/
# 	echo '##[ $@ ]##'
#

help: ## show this help
	@cat $(MAKEFILE_LIST) |
	grep -oP '^[a-zA-Z_-]+:.*?## .*$$' |
	sort |
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

delete: ## delete stow dotfiles
	echo '##[ $@ ]##'
	stow --verbose --dotfiles --delete --target ~/ .

reset-nvim:
	echo '##[ $@ ]##'
	rm -rf $(DATA_HOME)/nvim/*
	rm -rf $(STATE_HOME)/nvim/*
	rm -rf $(CACHE_HOME)/nvim/*
	stow --dotfiles --restow --target ~/ .

ql:
	host-spawn systemctl --user daemon-reload
	host-spawn systemctl --user list-unit-files --type=service --state=enabled
	host-spawn systemctl --user list-unit-files --type=image

pip: 
	# wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py --user
	# pip install --user pylatexenc latex2text
	pip install --user --upgrade pip
	pip list

timers:
	systemctl --user daemon-reload
	systemctl --user is-enabled lua-language-server-image
	systemctl --no-pager --user --all  list-timers

backup:
	rsync -av --delete $(PROJECTS)  $(HOME)/Backup/dotfiles-$$(date --iso)

dconf:
	dconf-writes

luarocks:
	printf "lua interpreter: %s \n" "$$(luarocks config lua_interpreter)"
	luarocks config variables

# timers:
# 	echo '##[ $@ ]##'
# 	systemctl --user daemon-reload
# 	echo $(wildcard dot-config/systemd/user/*.timer)
# 	$(foreach d,
# 	$(wildcard dot-config/systemd/user/*.timer),
# 	systemctl --user is<F2>-enabled --quiet $(notdir $(d))  || systemctl --user enable $(notdir $(d))
# 	)
# 	systemctl --no-pager --user --all list-timers | head -1
# 	$(foreach d, $(wildcard dot-config/systemd/user/*.timer),
# 	systemctl --no-pager --user --all  list-timers $(notdir $(d)) | grep $(basename $(notdir $(d)))
# 	#systemctl --user status $(notdir $(d))
# 	)

status:
	#systemctl --no-pager --ser --all list-timers
	systemctl --no-pager --user status ptyxis-toolbox.service

start:
	systemctl --user start ptyxis-toolbox.service

sys:
	systemctl disable NetworkManager-wait-online

files/lilex.zip:
	mkdir -p files
	URL=$$(wget -q -O - 'https://api.github.com/repos/mishamyrt/Lilex/releases/latest' | 
	jq -r '.assets[].browser_download_url')
	wget $${URL} -q -O $@

fonts: files/lilex.zip
	echo '##[[ $@ ]]##'
	# install latest lilex fonts into ~/.local/share/fonts
	# https://github.com/mishamyrt/Lilex/releases/latest
	# 
	# mkdir -p $(DATA_HOME)/fonts/lilex
	# unzip -q lilex.zip -d $(DATA_HOME)/fonts/lilex
	fc-cache -f -v $(DATA_HOME)/fonts

fonts-list:
	fc-list | grep Lilex

# - Lua
# - Markdown
# - Vimscript
# - Vimdoc
# - Treesitter query files |ft-query-plugin

###

TS_ROCKS := \
			awk \
			bash \
			comment \
			css \
			csv \
			diff \
			djot \
			dtd \
			ebnf \
			elixir \
			erlang \
			git_config \
			gitignore \
			gleam \
			gnuplot \
			html \
			http \
			javascript \
			jq \
			json \
			just \
			latex \
			ledger \
			make \
			markdown_inline \
			mermaid \
			nginx \
			printf \
			readline \
			regex \
			ssh_config \
			toml \
			xml \
			yaml

ROCKS  := $(patsubst %,tree-sitter-%,$(TS_ROCKS))
ROCKS_BINARIES := https://nvim-neorocks.github.io/rocks-binaries
ROCKS_PATH := $(DATA_HOME)/nvim/rocks
ROCKS_LIB_PATH := $(ROCKS_PATH)/lib/luarocks/rocks-5.1
lr_purge = luarocks purge --old-versions --tree $(ROCKS_PATH)
lr_purge_all = luarocks purge --force-fast --tree $(ROCKS_PATH)
lr_remove = luarocks remove --tree $(ROCKS_PATH) --force-fast --deps-mode one $1
lr_list_outdated = luarocks list --outdated --tree $(ROCKS_PATH)
# lr_outdated = luarocks list --outdated --tree $(ROCKS_PATH) $1
lr_show = luarocks show --tree $(ROCKS_PATH) $1
lr_show_version = $(shell luarocks show --mversion --tree $(ROCKS_PATH) $1)
rock_dir = $(ROCKS_LIB_PATH)/$1/$2
lr_install =  luarocks install \
			  --tree $(ROCKS_PATH) \
			  --server $(ROCKS_BINARIES) \
			  --no-doc \
			  --force-fast \
			  --deps-mode one $1
lr_search_bin =  luarocks search --porcelain --binary --server $(ROCKS_BINARIES) $1
lr_search =  luarocks search --server $(ROCKS_BINARIES) $1

lr:
	# $(call lr_purge_all)
	mkdir -p dot-config/nvim/parser
	mkdir -p dot-config/nvim/queries
	for ROCK in $(ROCKS)
	do
	printf " - %s %s " "$${ROCK}" "installed?"
	if ! luarocks list --tree $(ROCKS_PATH) $$ROCK | grep -q -oP  "$$ROCK"
	then
	printf "%s \n" "NOPE"
	printf "%s %s\n" " - installing" "$${ROCK}"
	$(call lr_install,$${ROCK})
	else
	printf "%s \n" "YEP"
	printf " - needs to be updated? "
	if luarocks list --outdated --tree $(ROCKS_PATH) $$ROCK | grep -q -oP  "$$ROCK"
	then
	printf "%s \n" "YEP"
	printf " - updating rock: %s \n" "$${ROCK}"
	$(call lr_install,$${ROCK})
	printf "%s \n" " - copy updated parser and queries into nvim runtime"
	else
	printf "%s \n" "NOPE"
	fi
	fi
	VER=$$(luarocks show --mversion --tree $(ROCKS_PATH) $$ROCK)
	DIR="$(ROCKS_LIB_PATH)/$$ROCK/$$VER"
	cp -f $${DIR}/parser/* dot-config/nvim/parser &>/dev/null
	cp -fr $${DIR}/queries/* dot-config/nvim/queries &>/dev/null
	done
