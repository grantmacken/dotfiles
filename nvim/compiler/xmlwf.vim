" Vim Compiler File
" Compiler:	xmlwf
" Maintainer:	Robert Rowsome <rowsome@wam.umd.edu>
" Last Change:	2004 Mar 27

let current_compiler = "xmlwf"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=xmlwf\ %

CompilerSet errorformat=%f:%l%c:%m

