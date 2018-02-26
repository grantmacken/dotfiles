SHELL=/bin/bash
include config
# include ../common.properties
export PATH := $(abspath ../bin):$(abspath ../node_modules/.bin):$(PATH)
# keep intermediate files
# http://stackoverflow.com/questions/3046117/gnu-makefile-multiple-outputs-from-single-rule-preventing-intermediate-files
.SECONDARY:

# Make sure we have the following apps installed:
reachable != dig @8.8.8.8 +short github.com
gitTag != $(git tag | head -1)


APP_LIST = git curl node tidy scour
assert-command-present = $(if $(shell which $1),,$(error '$1' missing and needed for this build))
$(foreach src,$(APP_LIST),$(call assert-command-present,$(src)))
# common functions
empty :=
space := $(empty) $(empty)
cat = $(shell if [ -e $(1) ] ;then echo "$$(<$(1))";fi )
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
TASKS_DIR := .tasks

include $(TASKS_DIR)/properties.mk

ifeq ($(shell git tag | head -1 ),)
 include $(TASKS_DIR)/init.mk
 VERSION != echo '0.0.1'
 else
 lastTag != if [ -e $(G)/tags.json ];then jq -r -c '.[0] | .name' $(G)/tags.json;fi
 releaseStrategy != if [ -e $(G)/issue.json ] ; then jq '.milestone.title' $(G)/issue.json; fi
 VERSION != echo "$(nextTag)" | sed 's/v//'
endif

XAR != echo "$(D)/$(ABBREV)-$(VERSION).xar"

include $(TASKS_DIR)/help.mk
include $(TASKS_DIR)/package.mk
# include $(TASKS_DIR)/build.mk
# include $(TASKS_DIR)/templates.mk
# include $(TASKS_DIR)/modules.mk
# include $(TASKS_DIR)/content.mk



# include $(TASKS_DIR)/repo.mk
# fo := $(TASKS_DIR)/repo.mk $(TASKS_DIR)/properties.mk
# include $(filter-out $(fo) ,$(wildcard $(TASKS_DIR)/*.mk))
# include $(TASKS_DIR)/repo.mk

default: help

.PHONY: help
