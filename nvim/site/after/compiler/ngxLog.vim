" Vim compiler file
" Compiler: ngxLog
" Maintainer: Grant MacKenzie
" Last Change: 2018
" h write-compiler-plugin
" h :compiler
let g:current_compiler = 'ngxLog'

CompilerSet makeprg=ngxLog

" file:line:column:type: message
"  %t  type: (Error Or Warning finds a single character E or W)
"  'E' error message
"  'W' warning message
"  'I' informational message

CompilerSet errorformat=
      \%f:%l:%t:\ %m,
      \%-G%.%#
