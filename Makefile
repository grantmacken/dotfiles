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

CONFIG_DIRS := /etc/xdg
DATA_DIRS   := /usr/local/share

CONFIG_HOME := $(HOME)/.config
CACHE_HOME  := $(HOME)/.cache
DATA_HOME   := $(HOME)/.local/share
STATE_HOME  := $(HOME)/.local/state
BIN_HOME    := $(HOME)/.local/bin

QUADLET := $(CONFIG_HOME)/containers/systemd
SYSTEMD := $(CONFIG_HOME)/systemd/user
# include $(INCLUDE)/gmsl
rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

#########
## LISTS
#########

bashList  := $(wildcard bash/*.sh)
bashBuild := $(patsubst bash/%,$(HOME)/.bashrc.d/%,$(bashList))

binList  := $(wildcard bin/*)
binBuild := $(patsubst bin/%,$(BIN_HOME)/%,$(binList))

gitList  := $(wildcard git/* )
gitBuild := $(patsubst git/%,$(CONFIG_HOME)/git/%,$(gitList))

ghList  := $(wildcard gh/*)
ghBuild := $(patsubst gh/%,$(CONFIG_HOME)/gh/%,$(ghList))

# gmslList  := gmsl/gmsl gmsl/__gmsl
# gmslBuild := $(patsubst gmsl/%,$(INCLUDE)/%,$(gmslList))
#
BUILDS := $(bashBuild) $(binBuild) $(gitBuild)

default: $(BUILDS)

clean:
	rm -vf $(BUILDS)

gh:
	echo '##[ $@ ]##'
	cd gh
	stow --no --target $(CONFIG_HOME)/$@


clean-bin:
	rm -vf $(binBuild)

$(BIN_HOME)/%: bin/%
	echo '##[ $@ ]##'
	mkdir -p $(dir $@)
	cp -v $(abspath $<) $(abspath $@)
	chmod +x $(abspath $@)
	whereis $*

$(HOME)/.bashrc.d/%.sh: bash/%.sh
	echo '##[ $@ ]##'
	mkdir -p $(dir $@)
	echo '##[ $(notdir $@) ]]##'
	ln -sf $(abspath $<) $(abspath $@)

$(CONFIG_HOME)/gh/%: gh/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)

$(CONFIG_HOME)/git/%: git/%
	mkdir -p $(dir $@)
	echo  $<
	# source_file symbolic_link
	ln -s  $(abspath $<) $(abspath $@)
