SHELL=/bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent
# include .env
CONFIG := $(HOME)/.config
CACHE := $(HOME)/.cache
DATA := $(HOME)/.local/share
STATE := $(HOME)/.local/state
LOCAL_BIN := $(HOME)/.local/bin

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

ghList  := $(wildcard gh/*)
ghBuild := $(patsubst gh/%,$(CONFIG)/gh/%,$(ghList))

gitList  := $(wildcard git/* )
gitBuild := $(patsubst git/%,$(CONFIG)/git/%,$(gitList))

nvimList  := $(call rwildcard,nvim,*.lua)
nvimBuild := $(patsubst nvim/%.lua,$(CONFIG)/nvim/%.lua,$(nvimList)) 

default: $(ghBuild) $(gitBuild) $(nvimBuild)

info:
	echo $(ghBuild) 
	echo $(gitBuild)


$(CONFIG)/nvim/%: nvim/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)


$(CONFIG)/gh/%: gh/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)

$(CONFIG)/git/%: git/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)



ostree:
	# https://universal-blue.discourse.group/docs?topic=40
	# remove layered packages
	rpm-ostree reset
	rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bluefin:39


kitty-session: $(HOME)/.config/kitty/session.conf
	cat << EOF | tee $@
	cd $HOME/zie
	launch /bin/bash -c 'distrobox enter zie-quadlet'
	EOF

kitty-install:
	# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
	# your system-wide PATH)
	ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
	# Place the kitty.desktop file somewhere it can be found by the OS
	cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
	# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
	cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
	# Update the paths to the kitty and its icon in the kitty.desktop file(s)
	sed -i "s|Icon=kitty|Icon=/home/$$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
	sed -i "s|Exec=kitty|Exec=/home/$$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
	echo '-------------------DONE ------------------------'


clean-nvim:
	rm -Rf $(CONFIG)/nvim || true
	rm -Rf $(DATA)/nvim || true
	rm -Rf $(STATE)/nvim || true
	

clean:
	rm -v $(ghBuild) || true
	rm -v $(gitBuild) || true
	rm -v $(nvimBuild) || true
