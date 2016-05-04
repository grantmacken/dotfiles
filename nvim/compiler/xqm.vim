" Vim compiler file
" Compiler:	xqm home made
" Maintainer: Grant MacKenzie
" Last Change:	2016 

let current_compiler = "xqm"

let s:cpo_save = &cpoptions
set cpoptions&vim

" only get stuff written to std err

CompilerSet makeprg=make\ modules\ 2>&1\ >/dev/null

" sample error:
" modules/lib/muURL.xqm:50:1:Error: unexpected token

CompilerSet errorformat=%f:%l:%c:%trror:\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
