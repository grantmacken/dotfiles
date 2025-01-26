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

CONTAINER_NAME=zie-toolbox-dx
IMAGE=ghcr.io/grantmacken/$(CONTAINER_NAME)

.PHONY: help mini

default: ## stow dotfiles
	echo '##[ stow dotfiles ]##'
	chmod +x dot-local/bin/*
	stow --verbose --dotfiles --target ~/ .
	echo ' - task completed'

parsers:
	echo '##[ $@ ]##'
	# cp $(DATA_HOME)/nvim/rocks/lib/lua/5.1/parser/* $(CONFIG_HOME)/nvim/parser/
	# 

queries:
	echo '##[ $@ ]##'


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

nativevim:
	git clone https://github.com/boltlessengineer/nativevim.git $(CONFIG_HOME)/nativevim

timers:
	systemctl --user daemon-reload
	systemctl --user is-enabled lua-language-server-image
	systemctl --no-pager --user --all  list-timers

bu:
	rsync -av --delete .  ~/Backup/dotfiles-$$(date --iso)

tbx:
	LOCAL_DIGEST=$$(podman image inspect $(IMAGE):latest | jq -r '.[0].Digest')
	REMOTE_DIGEST=$$(skopeo inspect docker://$(IMAGE):latest | jq -r '.Digest')
	printf "Remote Digest: %s\n" "$$REMOTE_DIGEST"
	printf " Local Digest: %s\n" "$$LOCAL_DIGEST"
	if [ "$$LOCAL_DIGEST" != "$$REMOTE_DIGEST" ];
	then
	echo "Local and Remote Digests do not match"
	echo "Pulling the latest image"
	podman pull $(IMAGE):latest
	fi

luarocks:
	printf "lua interpreter: %s \n" "$$(luarocks config lua_interpreter)"
	luarocks config variables
	

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
	#systemctl --no-pager --user --all list-timers
	systemctl --no-pager --user status ptyxis-toolbox.service

start:
	systemctl --user start ptyxis-toolbox.service

# for timer in $(SYSTEMD)/*.timer
# do
# echo  $(notdir $${timer})
# done

