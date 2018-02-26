" Vim compiler file
" Compiler: ngxTest home made
" Maintainer: Grant MacKenzie
" Last Change: 2018

let g:current_compiler = 'ngxTest'
let s:cpo_save = &cpoptions
set cpoptions&vim

let $PROVEFILE = g:my_test_file
CompilerSet makeprg=ngxProve\ $PROVEFILE

" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
" %t  type: (Error Or Warning finds a single character E or W)
"  'E' error message
"  'W' warning message
"  'I' informational message
" file:line:column:type: message

CompilerSet errorformat=%f:%l:%t:\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
