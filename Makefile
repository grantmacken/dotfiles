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
	# for rc in $(HOME)/.bashrc.d/*
	# do
	# source "$$rc"
	# done

# timers:
# 	echo '##[ $@ ]##'
# 	systemctl --user daemon-reload
# 	echo $(wildcard dot-config/systemd/user/*.timer)
# 	$(foreach d,
# 	$(wildcard dot-config/systemd/user/*.timer),
# 	systemctl --user is-enabled --quiet $(notdir $(d))  || systemctl --user enable $(notdir $(d))
# 	)
# 	systemctl --no-pager --user --all list-timers | head -1
# 	$(foreach d, $(wildcard dot-config/systemd/user/*.timer),
# 	systemctl --no-pager --user --all  list-timers $(notdir $(d)) | grep $(basename $(notdir $(d)))
# 	#systemctl --user status $(notdir $(d))
# 	)

status:
	systemctl --no-pager --user --all list-timers
	systemctl --no-pager --user status ptyxis-toolbox.service





	# for timer in $(SYSTEMD)/*.timer
	# do
	# echo  $(notdir $${timer})
	# done


delete:
	echo '##[ $@ ]##'
	stow --verbose --dotfiles --delete --target ~/ .
