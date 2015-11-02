" https://github.com/terryma/dotfiles/blob/master/.vimrc
" https://github.com/joedicastro/dotfiles/tree/master/vim

set nocompatible   " No to the total compatibility with the ancient vi

let $VIMPATH=expand('$HOME/.vim') 
let $VARPATH=expand('$HOME/.cache/vim')

function! s:source_file(path)
	execute 'source' fnameescape($VIMPATH.'/setup/'.a:path)
endfunction

" call s:source_file('init.vim')     "initialize base requirements
call s:source_file('plugins.vim')  "install plugins into plugged dir
call s:source_file('vimfiler.vim')
call s:source_file('unite.vim')
call s:source_file('plugged.vim')  "setup what the plugins can do

" Must be after plugins
filetype plugin indent on
syntax enable

call s:source_file('functions.vim')
call s:source_file('general.vim')

call s:source_file('leader-mappings.vim')

call s:source_file('menu-files.vim')
call s:source_file('menu-grep.vim')
call s:source_file('menu-navigation.vim')
"" 
"autocomands

" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!                
" " Set at the end to work around 'exrc'
set secure
