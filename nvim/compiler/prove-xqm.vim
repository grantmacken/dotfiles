" Vim compiler file
" Compiler:	xqm home made
" Maintainer: Grant MacKenzie
" Last Change:	2016 

let current_compiler = "prove-xqm"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
	command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=prove\ -v\ -\ <\ t/xqm.txt

" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
" %t  type: (Error Or Warning finds a single character E or W)
" file:line:column:type: message
CompilerSet errorformat=%f:%l:%c:%t:\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
