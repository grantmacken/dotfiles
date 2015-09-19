SHELL=/bin/bash

APP_LIST = git curl stow
assert-command-present = $(if $(shell which $1),,$(error '$1' missing and needed for this build))
$(foreach src,$(APP_LIST),$(call assert-command-present,$(src)))

GIT_USER="$(shell git config --get user.name )"
GIT_REMOTE_ORIGIN_URl="$(shell git config --get remote.origin.url )"
GIT_REPO_FULL_NAME="$(shell echo $(GIT_REMOTE_ORIGIN_URl) | sed -e 's/git@github.com://g' | sed -e 's/\.git//g' )"
GIT_REPO_NAME="$(shell echo $(GIT_REPO_FULL_NAME) |cut -d/ -f2 )"
GIT_REPO_OWNER_LOGIN="$(shell echo $(GIT_REPO_FULL_NAME) |cut -d/ -f1 )"

default: stow-all

stow-all:
	@echo 'GIT_USER': $(GIT_USER)
	@echo 'GIT_REMOTE_ORIGIN_URl': $(GIT_REMOTE_ORIGIN_URl)
	@echo 'GIT_REPO_FULL_NAME': $(GIT_REPO_FULL_NAME)
	@echo 'GIT_REPO_NAME': $(GIT_REPO_NAME)
	@echo 'GIT_REPO_OWNER_LOGIN': $(GIT_REPO_OWNER_LOGIN)
	@echo 'TASK': use stow to create symlinks in home dir
	@stow -v -t ~ bash
	@stow -v -t ~ tmux
	@stow -v -t ~ vim
	@stow -v -t ~/bin  bin

.PHONY: stow-all
