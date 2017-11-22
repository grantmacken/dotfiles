#!/bin/bash +x
################################
# cd into dir named after domain
################################

touch README.md
mkdir {data,build,deploy}
mkdir {.github,.tmp}
mkdir -p t/modules/lib
mkdir -p templates/{includes,pages,posts}
mkdir -p modules/{api,lib,render,tests/lib}
mkdir -p resources/{icons,images,scripts,styles}

