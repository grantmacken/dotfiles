SHELL=/bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent
ifndef XDG_CONFIG_HOME
XDG_CONFIG_HOME := $(HOME)/.config
endif

CACHE := $(HOME)/.cache
DATA := $(HOME)/.local/share
STATE := $(HOME)/.local/state
INCLUDE := $(HOME)/.local/include
BIN := $(HOME)/.local/bin
QUADLET := $(XDG_CONFIG_HOME)/containers/systemd
SYSTEMD := $(XDG_CONFIG_HOME)/systemd/user

include $(INCLUDE)/gmsl

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

#########
## LISTS
#########

bashrcList  := $(wildcard bashrc/*.sh)
bashrcBuild := $(patsubst bashrc/%,$(HOME)/.bashrc.d/%,$(bashrcList))

binList  := $(wildcard bin/*)
binBuild := $(patsubst bin/%,$(BIN)/%,$(binList))

ghList  := $(wildcard gh/*)
ghBuild := $(patsubst gh/%,$(XDG_CONFIG_HOME)/gh/%,$(ghList))

gitList  := $(wildcard git/* )
gitBuild := $(patsubst git/%,$(XDG_CONFIG_HOME)/git/%,$(gitList))

gmslList  := gmsl/gmsl gmsl/__gmsl
gmslBuild := $(patsubst gmsl/%,$(INCLUDE)/%,$(gmslList))

nvimList  := $(call rwildcard,nvim,*.lua)
nvimBuild := $(patsubst nvim/%.lua,$(XDG_CONFIG_HOME)/nvim/%.lua,$(nvimList))

kittyInit := kitty/session.conf
kittyList  := $(call rwildcard,kitty,*.conf)
kittyBuild := $(patsubst kitty/%.conf,$(XDG_CONFIG_HOME)/kitty/%.conf,$(kittyList))

default: $(binBuild) $(nvimBuild)

kill:
	systemctl --user daemon-reload
	ls -alR $(QUADLET)
	systemctl --no-pager --user list-unit-files  --state=generated
	systemctl --no-pager --user stop zie-toolbox.service || true
	systemctl --no-pager --user disable zie-toolbox.service || true
	rm $(QUADLET)/zie-toolbox.container || true

	# systemctl --no-pager --user status zie-toolbox.service
	# systemctl --no-pager --user  list-units --type=service
	# systemctl --no-pager --user show lua-language-server-image.service
	# echo '========================================================='
	# systemctl --no-pager --user show lua-language-server-image.service | grep -oP 'Can.+'
	# systemctl --no-pager --user start lua-language-server-image.service

logs:
	# podman images --format "{{.Repository}} id: {{.ID}} size: {{.Size}}"
	podman logs --latest
	# podman logs json-language-server
	# podman run --rm  --entrypoint '["bash-language-server", "--version" ]' ghcr.io/grantmacken/bash-language-server


luarocks:
	# which luarocks
	echo $(LUAROCKS_CONFIG)
	LUAROCKS_CONFIG='$(LUAROCKS_CONFIG)'
	echo $$LUAROCKS_CONFIG
	luarocks \
		--lua-version=5.1 \
		--tree /var/home/gmack/.local/share/nvim/rocks \
		--server='https://nvim-neorocks.github.io/rocks-binaries/'


clean-locks:
	rm /var/home/gmack/.local/share/nvim/rocks/lockfile.lfs || true
	rm /var/home/gmack/.local/share/nvim/rocks/.lock* || true

clean: clean-bin
	rm -v $(gitBuild) || true
	rm -v $(nvimBuild) || true

clean-bin:
	rm -v $(binBuild) || true

clean-nvim:
	rm -Rf $(XDG_CONFIG_HOME)/nvim || true
	rm -Rf $(DATA)/nvim || true
	rm -Rf $(STATE)/nvim || true

$(INCLUDE)/%: gmsl/%
	mkdir -p $(dir $@)
	echo '##[ $(notdir $@) ]]##'
	cp -v $< $@

$(HOME)/.bashrc.d/%.sh: bashrc/%.sh
	mkdir -p $(dir $@)
	echo '##[ $(notdir $@) ]]##'
	cp -v $< $@

$(BIN)/%: bin/%
	mkdir -p $(dir $@)
	chmod +x $<
	ln -s  $(abspath $<) $(abspath $@)
	which $*
	# ln -s  $(abspath $<) $(abspath $@)

info:
	$(info $(quadletImageList))
	$(info $(quadletBuild))

$(XDG_CONFIG_HOME)/kitty/%: kitty/%
	mkdir -p $(dir $@)
	echo  $<
	ln -s  $(abspath $<) $(abspath $@)

$(XDG_CONFIG_HOME)/nvim/%: nvim/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)

$(XDG_CONFIG_HOME)/gh/%: gh/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)

$(XDG_CONFIG_HOME)/git/%: git/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)

#####################################################

ostree:
	# https://universal-blue.discourse.group/docs?topic=40
	# remove layered packages
	rpm-ostree reset
	rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/bluefin:39

toolbox:
	systemctl --no-pager --user is-active zie-toolbox.service  || systemctl --no-pager --user start zie-toolbox.service
	echo -n ' - is enabled: ' && systemctl --no-pager --user is-enabled zie-toolbox.service || true
	echo -n ' - is active: '&& systemctl --no-pager --user is-active zie-toolbox.service || true
	distrobox ls

kitty/session.conf:
	cat << EOF | tee $@
	cd $(HOME)/zie
	# journalctl --no-pager --user -xeu zie-toolbox.service
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




# images: $(timerImageBuild)


