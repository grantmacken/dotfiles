
define packageHelp
=========================================================
package : create the 2 XML descriptor files 

    < src  'make templates'
     [ build ]    move files into build dir
==========================================================

```
make packages
make packages-help
```
ref:
```
https://exist-db.org/exist/apps/doc/repo.xml
```
Notes:

repo:
 target: is sites DOMAIN [ $(DOMAIN) ]
 author: as in config file: [ $(AUTHOR) ]
 description: as in config file: [ $(DESCIPTION) ]
 owner:  as git repo owner  [ $(OWNER) ]
 website: as build from domain prefixed with https:// [ $(WEBSITE) ]

package:
 name:   just use 'website' url
 abbrev: just use 'domain' name
 title:  just use 'domain' name
 version: as as git last release 'tag name'

 version is semver
   v{major}.{minor}.{patch}
  the starts-with v gets stripped
if no github release then start with
  v0.0.1




 installed into: [ /db/apps/$(DOMAIN) ]



endef




define repoXML
<meta xmlns="http://exist-db.org/xquery/repo">
  <description>$(DESCRIPTION)</description>
  <author>$(AUTHOR)</author>
  <website>$(WEBSITE)</website>
  <status>alpha</status>
  <license>GNU-LGPL</license>
  <copyright>true</copyright>
  <type>application</type>
  <target>$(DOMAIN)</target>
  <prepare>modules/pre-install.xq</prepare>
  <permissions user="$(OWNER)" group="$(OWNER)" mode="0775"/>
</meta>
endef

define expathPkgXML
<package xmlns="http://expath.org/ns/pkg"
  name="$(WEBSITE)"
  abbrev="$(DOMAIN)"
  spec="1.0"
  version="$(VERSION)">
  <title>$(DOMAIN)</title>
</package>
endef

define collectionXconf
<?xml version="1.0" encoding="UTF-8"?>
<collection xmlns="http://exist-db.org/collection-config/1.0">
    <index xmlns:xs="http://www.w3.org/2001/XMLSchema">
        <fulltext default="none" attributes="false"/>
    </index>
</collection>
endef

package-help: export packageHelp:=$(packageHelp)
package-help:
	@echo "$${packageHelp}"

pack1: export repoXML:=$(repoXML)
pack1:
	@echo "$${repoXML}" | tidy -q -xml -utf8 -e  --show-warnings no
	@echo "$${repoXML}" | tidy -q -xml -utf8 -i --indent-spaces 1 --output-file $(B)/repo.xml

pack2: export expathPkgXML:=$(expathPkgXML)
pack2:
	@echo "$${expathPkgXML}" | tidy -q -xml -utf8 -e
	@echo "$${expathPkgXML}" | tidy -q -xml -utf8 -i --indent-spaces 1 --output-file $(B)/expath-pkg.xml

pack3: export collectionXconf:=$(collectionXconf)
pack3:
	@echo "$${collectionXconf}" | tidy -q -xml -utf8 -e  --show-warnings no
	echo "$${collectionXconf}" > $(B)/collection.xconf

package:
	@echo "# $@ #"
	@$(MAKE) --silent pack1
	@$(MAKE) --silent pack2
	@$(MAKE) --silent pack3
