SHELL=/bin/bash
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

default:
	echo '##[ $@ ]##'
	stow --verbose --dotfiles --restow --target ~/ .

delete:
	echo '##[ $@ ]##'
	stow --verbose --dotfiles --delete --target ~/ .
