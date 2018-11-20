" Vim compiler file
" Compiler: mkLualib
" Maintainer: Grant MacKenzie
" Last Change: 2018
" h write-compiler-plugin
" h :compiler
let g:current_compiler = 'mkLualib'

CompilerSet makeprg=make\ lualib

" file:line:column:type: message
"  %t  type: (Error Or Warning finds a single character E or W)
"  'E' error message
"  'W' warning message
"  'I' informational message

CompilerSet errorformat=
 \%tnfo:%f:\ %m,
 \%tarn%f:\ %m,
 \%trror:%f:\ %m,
 \%-G%.%#
