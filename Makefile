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
unexport MAKEFLAGS

# XDG Base Directory paths
CONFIG_HOME := $(HOME)/.config
CACHE_HOME  := $(HOME)/.cache
DATA_HOME   := $(HOME)/.local/share
STATE_HOME  := $(HOME)/.local/state
BIN_HOME    := $(HOME)/.local/bin


default:  ## deploy dotfiles
	echo '##[ stow dotfiles ]##'
	# Ensure all scripts are executable before deployment
	chmod +x dot-local/bin/* || true
	echo ' - deploying dotfiles to home directory'
	stow --verbose --dotfiles --target ~/ .
	echo '✅ Stow completed task'

init:  ## initialize dotfiles
	echo '##[ $@ ]##'
	# Create XDG Base Directory structure
	mkdir -p $(BIN_HOME)
	mkdir -p $(CACHE_HOME)/nvim
	mkdir -p $(STATE_HOME)/{nvim,pi/sessions}
	# Neovim LSP (lua_ls) directories
	mkdir -p $(DATA_HOME)/{nvim/luals/{logs,meta},pi/packages}
	mkdir -p ${CONFIG_HOME}/nvim/{plugin,snippets,scripts,tests,templates,lua,after/{ftplugin,lsp,snippets}}
	echo '✅ completed task'

oldnvim:
	mkdir -p dot-config/oldnvim
	cp -r ../dots/dot-config/nvim/*  dot-config/oldnvim/
	cat << EOF
	To use the minmax change NVIM_APPNAME in your environment.
	EOF
	echo '✅ completed task'

minmax:
	if [ ! -d ../MiniMax ]
	then
	git clone --filter=blob:none https://github.com/nvim-mini/MiniMax ../MiniMax
	else
	pushd ../MiniMax
	git pull
	popd
	fi
	cp -r ../MiniMax/configs/nvim-0.13/*  dot-config/minmax/
	cat << EOF
	To use the minmax change NVIM_APPNAME in your environment.
	EOF
	echo '✅ completed task'


clean: ## remove stow symlinks (dry-run)
	echo '##[ stow --delete dry-run ]##'
	stow --simulate --verbose --delete --dotfiles --target ~/ .
	echo '##[ stow --delete run ]##'
	stow --verbose --dotfiles --delete  --target  ~/ .
	echo '✅ completed task'

reset_nvim:
	echo '##[ $@ ]##'
	echo '- removing stuff not under stow control...'
	rm -rf $(CACHE_HOME)/nvim
	rm -rf $(STATE_HOME)/nvim
	rm -rf $(DATA_HOME)/nvim
	echo '✅ completed task'

