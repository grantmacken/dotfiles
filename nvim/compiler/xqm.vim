" Vim compiler file
" Compiler:	xqm home made
" Maintainer: Grant MacKenzie
" Last Change:	2016 

let current_compiler = "xqm"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
	command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=make\ modules

" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
CompilerSet errorformat=%A%f:%l:%c: %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
