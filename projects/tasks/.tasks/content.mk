#==========================================================
# CONTENT
#  content is the working directory for entries written in markdown
#  contentType ( pages |  posts )
#  postTypes   ( articles | notes )
#
#  {project}/content{contentType}
#  pages =  entries in a named collection hierachy
#  {project}/content/pages/{collectionName}
#  posts =  entries in a date stamped archive
#  {project}/content/posts/{postType}
#
# markdown is stored on server using the following template URI https://tools.ietf.org/html/rfc6570
#  /db/data/{project}/posts/{postType}/{year}-{month}-{day}-{name}
#  /db/data/{project}/pages/{collection}/{name}
# interaction with data is via restxq
# http://exquery.github.io/exquery/exquery-restxq-specification/restxq-1.0-specification.html
#
#
#############################################################

SRC_ARTICLES:= $(shell find $(C)/articles -name '*.md' )
ARTICLES     := $(patsubst $(C)/articles/%.md,$(T)/articles/%.xhtml,$(SRC_ARTICLES))

define articleTemplate
<!---
title: [TITLE] 
created: $(shell date --iso)
draft:   true
tags:
-->

### title

 Posuere facilisis eros nulla sed dolor, ac pede elementum praesent arcu est
tellus, maecenas molestie nonummy adipiscing, elit bibendum. Mollis consequat
donec sollicitudin, luctus vel, maecenas aliquam quam pellentesque vivamus wisi
vel, mi in at congue pretium. Nec mauris dignissim donec phasellus vel, dui
lorem eget magna vestibulum, ultrices sit nam, lectus odio mauris laoreet
vestibulum sodales. Lectus quam, risus non ac in lectus dapibus, lorem turpis
condimentum lorem, malesuada potenti, sociis est. Id quis felis, viverra
euismod, libero mauris augue tristique faucibus augue donec. Odio in, enim
dolor est vel ullamcorper, amet nec sed nunc sem, tempus elit bibendum urna mi.


 Viverra wisi, egestas quam suspendisse, volutpat cras erat aliquam, amet nunc,
cras eros placerat justo. Sed semper a error a volutpat. Odio senectus in
tincidunt, eget posuere luctus ipsum voluptate justo cursus, massa tincidunt
nec integer lacus. Ornare elementum eleifend ultricies proin, donec et ligula
fusce. Nec faucibus, velit mauris nascetur morbi nam eros, mauris ut et.
Viverra purus lectus, sed molestie turpis ipsum, netus et vivamus sagittis
auctor et in, cras eget eget urna.

endef

article: export mkArticleTemplate:=$(articleTemplate)
article:
	@echo "## $@ ##"
	@read -p "enter unique title ➥ " title;\
 echo "$${mkArticleTemplate}" | \
 sed "s/^title:.*/title: '$$title'/" | \
 sed -r "s/^##.*/## $$title/"  \
 > $(C)/articles/$(shell date --iso)-$$(echo $${title} | sed 's/ /_/g').md


content: $(ARTICLES)

watch-content:
	@watch -q $(MAKE) content

.PHONY:   watch-content


$(T)/articles/%.xhtml: $(C)/articles/*.md
	@echo "## $@ ##"
	@mkdir -p $(@D)
	@echo "SRC: $<"
	@echo "$(call cat,$<)"
	@resty -e 'local h = require("resty.hoedown");print(h[[# Hello World]])'

ssasas:
	@echo "eXist content collection_uri: $(join apps/,$(NAME))"
	@echo "directory in file system: $(subst $(<),,$(abspath  $(<)))"
	@echo "eXist store pattern: : $(<) "
	@echo "mime-type: $(call getMimeType,$(suffix $(notdir $(<))))"
	@mkdir -p $(L)/$*
	@xq store-built-resource \
 '$(join apps/,$(NAME))' \
 '$(subst $(<),,$(abspath  $(<)))' \
 '$(<)' \
 '$(call getMimeType,$(suffix $(notdir $(<))))' \
 'content/$*'
	@echo '-----------------------------------------------------------------'

$(L)/content/%.json: $(L)/content/%.log
	@echo "## $@ ##"
	@echo "SRC: $<"
	@echo "input log: $<"
	@echo "input log last item: $(shell tail -n 1 $<)"
	@echo "output log: $@"
	@echo "suffix: $(suffix $(shell tail -n 1 $<)) "
	@curl -s --ipv4  http://localhost:35729/changed?files=$(shell tail -n 1 $<) > $@
	@echo "output last livereload item: $(shell tail -n 1 $@  | jq -r  '.files[0]')"
	@echo '-----------------------------------------------------------------'
