" Vim compiler file
" Compiler: xxQprove home made
" Maintainer: Grant MacKenzie
" Last Change: 2017

let g:current_compiler = 'xQprove'
let s:cpo_save = &cpoptions
set cpoptions&vim

function! s:GetProveFile()
  if !empty(b:projectionist)
    for [ l:root, l:value] in projectionist#query('prove')
      return l:value
      break
    endfor
  endif
endfunction

let $PROVEFILE =  s:GetProveFile()

CompilerSet makeprg=xQprove\ $PROVEFILE

" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
" %t  type: (Error Or Warning finds a single character E or W)
" file:line:column:type: message
CompilerSet errorformat=%f:%l:%t:\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save
