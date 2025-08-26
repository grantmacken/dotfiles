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

default: init ## stow dotfiles
	echo '##[ stow dotfiles ]##'
	stow --verbose --dotfiles --target ~/ .
	fc-cache -f -v $(DATA_HOME)/fonts
	echo ' - task completed'
	
init: 
	echo '##[ $@ ]##'
	mkdir -p files dot-local/bin  dot-local/share/fonts dot-config dot-bashrc.d
	chmod +x dot-local/bin/* &>/dev/null || true


files/lilex.zip:
	mkdir -p files
	URL=$$(wget -q -O - 'https://api.github.com/repos/mishamyrt/Lilex/releases/latest' | 
	jq -r '.assets[].browser_download_url')
	wget $${URL} -q -O $@

fonts: files/lilex.zip
	echo '##[[ $@ ]]##'
	# install latest lilex fonts into ~/.local/share/fonts
	# mkdir -p $(DATA_HOME)/fonts/lilex
	unzip -q $< -d dot-local/share/fonts/lilex
	# fc-cache -f -v $(DATA_HOME)/fonts
