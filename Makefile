SHELL=/bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent
# include .env
ifndef XDG_CONFIG_HOME
XDG_CONFIG_HOME := $(HOME)/.config
endif

CACHE := $(HOME)/.cache
DATA := $(HOME)/.local/share
STATE := $(HOME)/.local/state
LOCAL_BIN := $(HOME)/.local/bin
QUADLET := $(XDG_CONFIG_HOME)/containers/systemd
SYSTEMD := $(XDG_CONFIG_HOME)/systemd/user

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

quadletImageNames := lua-language-server
quadletImageBuild := $(patsubst %,$(QUADLET)/%.image,$(quadletImageNames))
timerImageBuild := $(patsubst %,$(SYSTEMD)/%-image.timer,$(quadletImageNames))

quadletContainerNames := zie-toolbox
quadletContainerBuild := $(patsubst %,$(QUADLET)/%.container,$(quadletContainerNames))

binList  := $(wildcard bin/*)
binBuild := $(patsubst bin/%,$(LOCAL_BIN)/%,$(binList))

ghList  := $(wildcard gh/*)
ghBuild := $(patsubst gh/%,$(XDG_CONFIG_HOME)/gh/%,$(ghList))

gitList  := $(wildcard git/* )
gitBuild := $(patsubst git/%,$(XDG_CONFIG_HOME)/git/%,$(gitList))

nvimList  := $(call rwildcard,nvim,*.lua)
nvimBuild := $(patsubst nvim/%.lua,$(XDG_CONFIG_HOME)/nvim/%.lua,$(nvimList))

kittyInit := kitty/session.conf
kittyList  := $(call rwildcard,kitty,*.conf)
kittyBuild := $(patsubst kitty/%.conf,$(XDG_CONFIG_HOME)/kitty/%.conf,$(kittyList))

default: $(quadletContainerBuild)

images: $(timerImageBuild)

dots: $(binBuild) $(kittyInit) $(kittyBuild) $(ghBuild) $(gitBuild) $(nvimBuild)

debug:
	systemctl --no-pager --user  list-units --type=service
	systemctl --no-pager --user  list-units --type=target 


check:
	systemctl --user daemon-reload
	ls -alR $(QUADLET)
	systemctl --no-pager --user list-unit-files  --state=generated
	systemctl --no-pager --user is-active zie-toolbox.service || true
	systemctl --no-pager --user is-enabled zie-toolbox.service || true
	systemctl --no-pager --user status zie-toolbox.service
	# systemctl --no-pager --user  list-units --type=service
	# systemctl --no-pager --user show lua-language-server-image.service
	# echo '========================================================='
	# systemctl --no-pager --user show lua-language-server-image.service | grep -oP 'Can.+'
	# systemctl --no-pager --user start lua-language-server-image.service

timers:
	systemctl --no-pager --user list-timers --all lua-language-server-image.timer
	systemctl --no-pager --user cat lua-language-server-image.timer
	systemctl --no-pager --user show lua-language-server-image.timer | grep -oP 'Can.+'
	systemctl --no-pager --user  list-units  --failed
	systemctl --no-pager --user show lua-language-server-image.timer | grep -oP 'Desc.+'
	systemctl --no-pager --user show lua-language-server-image.timer | grep -oP 'Trig.+'
	systemctl --no-pager --user show lua-language-server-image.timer | grep -oP 'Load.+'

journal:
	journalctl --user -f -u lua-language-server-image.service

loginctl:
	#NOTE: i think the timers.target requires linger to be setup
	loginctl list-users
	loginctl enable-linger $(shell whoami)
	loginctl list-users

	# systemctl --no-pager --user status
	# echo  $(quadletBuild)
	# ls -al $(QUADLET)
	# systemctl cat lua-language-server || true
	# # Review the generated service.
	# systemctl --user is-enabled  lua-language-server || systemctl --user enable lua-language-server.service
	# systemctl cat lua-language-server
	# /usr/lib/systemd/system-generators/podman-system-generator --user
	# systemctl --no-pager --user start lua-luanguage-server
	# systemd-analyze --no-pager --user verify $(XDG_CONFIG_HOME)/systemd/user/*
	# systemctl --no-pager --user  list-units --type=service
	# systemctl --no-pager --user  list-units | grep lua

quadletsClean:
	rm  $(quadletContainerBuild) || true
	ls -al $(QUADLET)
	systemctl --user daemon-reload


# https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html#image-units-image
# The generated service is a one-time command that ensures that the image exists on the host, 
# pulling it if needed.
$(QUADLET)/%.image:
	echo '##[ $* quadlet image ]##'
	mkdir -p $(dir $@)
	cat << EOF | tee $@
	[Unit]
	Description=$* image
	After=local-fs.target network-online.target
	[Image]
	Image=ghcr.io/grantmacken/$*:latest
	[Service]
	TimeoutStartSec=120
	EOF
	systemctl --user daemon-reload
	systemctl --no-pager --user list-unit-files  --state=generated | grep $*
	systemctl --no-pager --user show $*-image.service | grep -oP '^UnitFile.+$$' 
	systemctl --no-pager --user show $*.service
	echo '-------------------------------------------------'

$(SYSTEMD)/%-image.timer: $(QUADLET)/%.image
	echo '##[ $(notdir $@) ]##'
	mkdir -p $(dir $@)
	cat << EOF | tee $@
	[Unit]
	Description=Pull latest $(*) image every week
	[Timer]
	OnCalendar=Mon, 04:10
	AccuracySec=12h
	Persistent=true
	[Install]
	WantedBy=timers.target
	EOF
	echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
	systemctl --user daemon-reload
	systemctl --user is-enabled $(notdir $@)  || systemctl --user enable $(notdir $@)
	systemctl --no-pager --user list-timers $(notdir $@)
	echo '-------------------------------------------------'
	systemctl --no-pager --user show $*.service
	echo '-------------------------------------------------'


# TODO check often if up to date
# https://raw.githubusercontent.com/ublue-os/toolboxes/main/quadlets/wolfi-toolbox/wolfi-distrobox-quadlet.container
$(QUADLET)/%.container: quadlets/%.container
	mkdir -p $(dir $@)
	echo '##[ $(notdir $@) ]]##'
	cp -v $< $@
	systemctl --user daemon-reload
	systemctl --no-pager --user show $*.service
	systemctl --no-pager --user list-unit-files  --state=generated | grep $*
	# systemctl --no-pager --user show $*.service | grep -oP '^UnitFile.+$$' 
	# systemctl --no-pager --user show $*.service | grep -oP '^Load.+$$' 
	# systemctl --no-pager --user show $*.service | grep -oP '^Active.+$$' 
	# systemctl --no-pager --user status $*.service | grep -oP 'Active.+'
	# echo -n ' - is enabled: ' && systemctl --no-pager --user is-enabled zie-toolbox.service || true
	systemctl --no-pager --user is-active $*.service || systemctl --user start $*.service
	systemctl --no-pager --user status $*.service
	echo -n ' - is active: ' && systemctl --no-pager --user is-active $*.service || true
	
$(LOCAL_BIN)/%: bin/%
		mkdir -p $(dir $@)
		echo  $<
		ln -s  $(abspath $<) $(abspath $@)


info:
	echo $(ghBuild) 
	echo $(gitBuild)

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


clean-nvim:
	rm -Rf $(XDG_CONFIG_HOME)/nvim || true
	rm -Rf $(DATA)/nvim || true
	rm -Rf $(STATE)/nvim || true
	

clean:
	rm -v $(ghBuild) || true
	rm -v $(gitBuild) || true
	rm -v $(nvimBuild) || true




