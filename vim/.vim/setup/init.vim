" ViM initialization
" ------------------
"

let mapleader=','
" menu prefix key
" let maplocalleader = ' '

"  Global Mappings "{{{
 " Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader="\<Space>"
"let g:mapleader=","
let g:maplocalleader=','

 " Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
" }}}
 "
 "
"  Set augroup "{{{
augroup MyAutoCmd
 autocmd!
augroup END

" }}}

" Disable pre-bundled plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

