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

WGET := wget -q --no-check-certificate --timeout=10 --tries=3

default: # init fonts ## stow dotfiles
	echo '##[ stow dotfiles ]##'
	chmod +x dot-local/bin/* || true
	stow --verbose --dotfiles --target ~/ .
	# fc-cache -f -v $(DATA_HOME)/fonts
	echo '✅ completed task'

delete: ## delete stow dotfiles
	echo '##[ $@ ]##'
	stow --verbose --dotfiles --delete --target ~/ .

init:
	echo '##[ $@ ]##'
	mkdir $(BIN_HOME)
	mkdir -p files latest dot-local/bin  dot-local/share/fonts dot-config dot-bashrc.d
	chmod +x dot-local/bin/* &>/dev/null || true


latest/lilex.json:
	echo '##[[ $@ ]]##'
	$(WGET) https://api.github.com/repos/mishamyrt/Lilex/releases/latest -O $@

files/lilex.zip: latest/lilex.json
	$(WGET) $(shell jq -r '.assets[].browser_download_url' $<) -O $@ 

fonts: files/lilex.zip
	echo '##[[ $@ ]]##'
	# install latest lilex fonts into ~/.local/share/fonts
	unzip -qo $< -d dot-local/share/fonts/lilex
