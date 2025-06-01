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

CONTAINER_NAME=zie-toolbox-dx
IMAGE=ghcr.io/grantmacken/$(CONTAINER_NAME)

.PHONY: help mini

default: delete ## stow dotfiles
	echo '##[ stow dotfiles ]##'
	chmod +x dot-local/bin/*
	stow --verbose --dotfiles --target ~/ .
	echo ' - task completed'

parsers:
	echo '##[ $@ ]##'
	# cp $(DATA_HOME)/nvim/rocks/lib/lua/5.1/parser/* $(CONFIG_HOME)/nvim/parser/
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

backup:
	rsync -av --delete $(PROJECTS)  $(HOME)/Backup/dotfiles-$$(date --iso)

pull:
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

xxx:
	if toolbox list containers | grep -q "$(CONTAINER_NAME)"
	then
	echo " - 1: Remove the toolbox container $(CONTAINER_NAME)"
	toolbox rm -f $(CONTAINER_NAME) &>/dev/null
	echo " - 2: Recreate toolbox from the latest image and"
	echo "      give it the same name as the removed container"
	toolbox create --image $(IMAGE) ${CONTAINER_NAME} &>/dev/null
	else
	echo " -----------------------------------------------------------"
	echo " Create the toolbox container with name: $(CONTAINER_NAME)  "
	echo " -----------------------------------------------------------"
	toolbox create --image $(IMAGE):latest $(CONTAINER_NAME)
	fi


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
	#systemctl --no-pager --user --all list-timers
	systemctl --no-pager --user status ptyxis-toolbox.service

start:
	systemctl --user start ptyxis-toolbox.service

sys:
	systemctl disable NetworkManager-wait-online


files/lilex.zip:
	mkdir -p files
	URL=$$(wget -q -O - 'https://api.github.com/repos/mishamyrt/Lilex/releases/latest' | jq -r '.assets[].browser_download_url')
	wget $${URL} -q -O $@


fonts: files/lilex.zip
	# install latest lilex fonts into ~/.local/share/fonts
	# https://github.com/mishamyrt/Lilex/releases/latest
	# mkdir -p $(DATA_HOME)/fonts/lilex
	# unzip -q lilex.zip -d $(DATA_HOME)/fonts/lilex
	fc-cache -f -v $(DATA_HOME)/fonts

fonts-list:
	fc-list | grep Lilex

