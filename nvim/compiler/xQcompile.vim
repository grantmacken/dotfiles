" Vim compiler file
" Compiler:	xqm home made
" Maintainer: Grant MacKenzie
" Last Change:	2016 

let current_compiler = "xQcompile"

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=xQcompile\ %

" gf ../../../mk-tasks/bin/xQcompile
" sample error:
" modules/lib/muURL.xqm:50:1:Error: unexpected token
" xqm Patterns that will be recognized by QuickFix.

" CompilerSet errorformat=%f:%l:%c:%trror:\ %m
" CompilerSet errorformat+=%f:%l:%trror:\ %m
CompilerSet errorformat+=%f:%l:%t:\ %m
" CompilerSet errorformat+=%f:%l:%c:%tarning:\ %m
" CompilerSet errorformat+=%f:%l:%tarning:\ %m
" CompilerSet errorformat+=%E#\ \ \ at\ %f\ line\ %l.
" CompilerSet errorformat+=%C#\ \ \ \ \ %m
" CompilerSet errorformat+=%Z#\ %#%m
"#   Failed test 'GET '/posts' should respond with http status code '200' '
"#   at t/modules/api/posts.t line 22.

let &cpoptions = s:cpo_save
unlet s:cpo_save
