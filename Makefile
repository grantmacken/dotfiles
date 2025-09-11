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

# WGET := wget -q --no-check-certificate --timeout=10 --tries=3
# https://docs.rockylinux.org/10/books/nvchad/nerd_fonts/

default: # init fonts ## stow dotfiles
	echo '##[ stow dotfiles ]##'
	chmod +x dot-local/bin/* || true
	stow --verbose --dotfiles --target ~/ .
	echo '✅ completed task'

delete: ## delete stow dotfiles
	echo '##[ $@ ]##'
	stow --verbose --dotfiles --delete --target ~/ .
	echo '✅ completed task'

init:
	echo '##[ $@ ]##'
	mkdir -p $(BIN_HOME)
	mkdir -p $(CACHE_HOME)/nvim
	mkdir -p $(STATE_HOME)/nvim
	mkdir -p -v $(DATA_HOME)/nvim/luals/{logs,meta}
	mkdir -p files latest dot-local/bin  dot-config dot-bashrc.d
	chmod +x dot-local/bin/* &>/dev/null || true

clean_nvim:
	rm -rf $(CACHE_HOME)/nvim
	rm -rf $(STATE_HOME)/nvim
	rm -rf $(DATA_HOME)/nvim
	rm -rf $(CONFIG_HOME)/nvim
	$(MAKE)
