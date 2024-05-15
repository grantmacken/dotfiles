SHELL=/bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

INCLUDE := $(HOME)/.local/include
include $(INCLUDE)/gmsl

ifndef XDG_CONFIG_HOME
XDG_CONFIG_HOME := $(HOME)/.config
endif
BIN := $(HOME)/.local/bin


QUADLET := $(XDG_CONFIG_HOME)/containers/systemd
SYSTEMD := $(XDG_CONFIG_HOME)/systemd/user

DayStack = Mon Tue Wed Thu Fri
HourStack = 01  02  03  04 05
MinStack =  05 15 25 35 45 55
stackr = $(foreach d,$1,$(call push,$2,$d))
$(call stackr,$(call reverse, $(MinStack)),mins)
$(call stackr,$(call reverse, $(HourStack)),hours)
$(call stackr,$(call reverse, $(DayStack)),days)

CHAINGUARD_PREFIX := cgr.dev/chainguard/
GRANTMACKEN_PREFIX = ghcr.io/grantmacken/

# grantmackenImages = $(call set_create, lua-language-server)
grantmackenImages = $(call set_create, \
bash-language-server \
gleam \
lua-language-server \
vscode-langservers-extracted \
yaml-language-server \
)

chainguardImages =  $(call set_create, wolfi-base)
# ocaml-lsp-server gopls gleam-language-server lemminx jsonls yamlls html-languageserver
quadletImageNames := $(grantmackenImages) $(chainguardImages)
quadletImageBuild := $(patsubst %,$(QUADLET)/%.image,$(quadletImageNames))
timerImageBuild := $(patsubst %,$(SYSTEMD)/%-image.timer,$(quadletImageNames))

default: $(quadletImageBuild) $(timerImageBuild) ## Create quadlet Image files and associated timers

help: ## show this help
	@cat $(MAKEFILE_LIST) |
	grep -oP '^[a-zA-Z_-]+:.*?## .*$$' |
	sort |
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Remove quadlet image files and associated timers
	systemctl --user daemon-reload
	for name in $(grantmackenImages)
	do
	echo "Name: $${name}"
	systemctl --user disable $${name}-image.timer || true
	systemctl --user stop $${name}-image.timer || true
	systemctl --user status $${name}-image.timer || true
	done
	# systemctl --no-pager --user --all list-timers $${name}-image.timer || true
	rm -f $(quadletImageBuild)
	rm -f $(timerImageBuild)
	systemctl --user daemon-reload

status:
	for name in $(grantmackenImages)
	do
	echo "Name: $${name}"
	systemctl --no-pager --user list-unit-files  --state=generated | grep $${name} || true
	systemctl --no-pager --user show $${name}-image.service | grep -oP '^CanS.+$$'
	echo ' - show timer details'
	# timer should activate on boot, this should pull latest image
	systemctl --no-pager --user --all list-timers $${name}-image.timer || true
	systemctl --no-pager --user show $${name}-image.service | grep -oP '^CanS.+$$'
	# podman images | grep -q $${PREFIX}/$* || podman pull $${PREFIX}/$*:latest
	echo '----------------------------------------------'
	done
	# echo $(SYSTEMD)/$${name}-image.timer
	# echo $(QUADLET)/$${name}.image
	# podman images | grep -oP "ghcr.io/grantmacken/$${name}.+" || true
	# ls -al $(SYSTEMD)/$${name}.image || true
	# ls -al $(QUADLET)/$${name}.image || true
	# systemctl --no-pager --user list-unit-files  --state=generated | grep $${name}
	# systemctl --no-pager --user show $${name}-image.service | grep -oP '^UnitFile.+$$'
	#podman images | grep -oP 'ghcr.io/grantmacken/.+$$'
# echo 'toolbox container name: zie-quadlet'
# podman images | grep -oP 'ghcr.io/grantmacken/zie-toolbox.+'
# systemctl --no-pager --user status zie-toolbox || true

# https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html#image-units-image
# The generated service is a one-time command that ensures that the image exists on the host, 
# pulling it if needed.
$(QUADLET)/%.image:
	echo '##[ $* quadlet image ]##'
	mkdir -p $(dir $@)
	$(if $(call set_is_member,$*,$(grantmackenImages)),
	PREFIX=ghcr.io/grantmacken,
	PREFIX=cgr.dev/chainguard)
	cat << EOF | tee $@
	[Unit]
	Description=$* image
	[Image]
	Image=$${PREFIX}/$*:latest
	EOF
	# systemctl --user daemon-reload
	# systemctl --no-pager --user list-unit-files  --state=generated | grep $*
	# # systemctl --no-pager --user show $*-image.service | grep -oP '^UnitFile.+$$'
	# systemctl --no-pager --user show $*-image.service | grep -oP '^CanS.+$$'
	# podman images | grep -q $${PREFIX}/$* || podman pull $${PREFIX}/$*:latest
	echo '-------------------------------------------------'


$(SYSTEMD)/%-image.timer: $(QUADLET)/%.image
	echo '##[ $(notdir $@) ]##'
	mkdir -p $(dir $@)
	MIN='$(call peek,mins)'
	HOUR='$(call peek,hours)'
	DAY='$(call peek,days)'
	cat << EOF | tee $@
	[Unit]
	Description= $(*) pulled every $${DAY}, $${HOUR}:$${MIN}
	[Timer]
	OnCalendar=$${DAY}, $${HOUR}:$${MIN}
	AccuracySec=12h
	Persistent=true
	[Install]
	WantedBy=timers.target
	EOF
	$(if $(call sne,$(call depth,mins),0),
	cat << EOF
	day:  $(call peek,days)
	hour: $(call peek,hours)
	min: $(call pop,mins)
	EOF,
	$(call stackr,$(call reverse, $(MinStack)),mins)
	cat << EOF
	day:  $(call peek,days)
	hour: $(call pop,hours)
	min: $(call peek,mins)
	EOF
	)
	echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
	systemctl --user daemon-reload
	systemctl --user is-enabled $(notdir $@)  || systemctl --user enable $(notdir $@)
	systemctl --no-pager --user --all  list-timers $(notdir $@)
	echo '-------------------------------------------------'
	# systemctl --no-pager --user show $*.service
	# echo '-------------------------------------------------'
	#
gleam-bin: $(BIN)/gleam-language-server

$(BIN)/gleam-language-server:
	podman images | grep -q ghcr.io/grantmacken/gleam || podman pull ghcr.io/grantmacken/gleam:latest
	cat << EOF | tee $@
	#!/usr/bin/env bash
	podman run --interactive --rm  ghcr.io/grantmacken/gleam lsp
	EOF
	chmod +x $@

	# cp -v $< $@
	# systemctl --user daemon-reload
	# systemctl --no-pager --user show $*.service
	# systemctl --no-pager --user list-unit-files  --state=generated | grep $*

# TODO check often if up to date
# https://raw.githubusercontent.com/ublue-os/toolboxes/main/quadlets/wolfi-toolbox/wolfi-distrobox-quadlet.container
# $(QUADLET)/%.container: quadlets/%.container
# 	mkdir -p $(dir $@)
# 	echo '##[ $(notdir $@) ]]##'
# 	cp -v $< $@
# 	systemctl --user daemon-reload
# 	systemctl --no-pager --user show $*.service
# 	systemctl --no-pager --user list-unit-files  --state=generated | grep $*
# 	# systemctl --no-pager --user show $*.service | grep -oP '^UnitFile.+$$' 
# 	# systemctl --no-pager --user show $*.service | grep -oP '^Load.+$$' 
# 	# systemctl --no-pager --user show $*.service | grep -oP '^Active.+$$' 
# 	# systemctl --no-pager --user status $*.service | grep -oP 'Active.+'
# 	# echo -n ' - is enabled: ' && systemctl --no-pager --user is-enabled zie-toolbox.service || true
# 	systemctl --no-pager --user is-active $*.service || systemctl --user start $*.service
# 	systemctl --no-pager --user status $*.service
# 	echo -n ' - is active: ' && systemctl --no-pager --user is-active $*.service || true

# $(QUADLET)/%.timer:	$(QUADLET)/%.image

# $(QUADLET)/%.image: quadlets/%.image
# 	mkdir -p $(dir $@)
# 	echo '##[ $* ]]##'
# 	echo ' - use quadlet *image* to generate a one-shot systemd service '
# 	cp -v $< $@
# 	echo ' - reload daemon'
# 	systemctl --user daemon-reload
# 	systemctl --no-pager --user list-unit-files  --state=generated | grep -oP '$*.+'
# 	systemctl --no-pager --user show $*-image.service | grep -oP 'Can.+'
# 	systemctl --no-pager --user is-active $*-image.service || systemctl --no-pager --user start $*-image.service 

# check2:
# 	echo ' - check: unit-files generated'
# 	echo '========================================================='
# 	systemctl --no-pager --user show $*-image.service
# 	systemctl --no-pager --user show $*-image.service | grep -oP 'Can.+'
# 	systemctl --no-pager --user is-active $*-image.service

# dots: $(binBuild) $(kittyInit) $(kittyBuild) $(ghBuild) $(gitBuild) $(nvimBuild)
#
#
# quadlets: $(quadletBuild)
#	# systemd-analyze --no-pager --user verify $(XDG_CONFIG_HOME)/systemd/user/*
	# systemctl --no-pager --user  list-units --type=service
	# systemctl --no-pager --user  list-units | grep lua





cat:
	systemctl --no-pager --user  cat bash-language-server-image.service
	systemctl --no-pager --user  cat lua-language-server-image.service

debug:
	systemctl --no-pager --user  list-units --type=service
	systemctl --no-pager --user  list-units --type=target
	systemctl --no-pager --user  list-units --type=timer
	systemctl --no-pager --user  cat  zie-toolbox.service

auto-update:
	#systemctl --no-pager  --user enable --now podman-auto-update.timer
	systemctl --no-pager --user list-unit-files --type=timer
	# podman auto-update --dry-run --format "{{.Image}} {{.Updated}}"

check:
	systemctl --user daemon-reload
	ls -alR $(QUADLET)
	# systemctl --no-pager --user list-unit-files  --state=generated
	systemctl --no-pager --user is-enabled zie-toolbox.service || true
	systemctl --no-pager --user is-active zie-toolbox.service || systemctl --no-pager --user start zie-toolbox.service
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

