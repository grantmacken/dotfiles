" FILE: nvim/site/after/plugin/accio.vim 
" Maintainer: Grant Mackenzie
"
" Accio setting
" Compile Build Test with Accio
" Used for Async
" - Check             [ 'format', 'lint' ] ( on buffer text change  )
" - Compile Builds    [ 'compile' ]        ( on save compile )
" - Test              [ 'prove' ]          ( on build run assertion and functional tests )

" Feedback
" - Populating the quickfix list
" - Placing signs on the line of the found error
" - Echoing the error message when the cursor is on an error line.
" @see compiler

let g:accio_create_empty_quickfix = 1
let g:accio_auto_copen = 1 "automatically open quick list
" let g:accio_update_interval = 250

" Note:  Noah Frederick's  after ... sets text and signs
" @see gf 'after/plugin/accio.vim'
" @see 'Noah Frederick'

" NOTE:
" one filetype can have any compilers
" HTML
" @see 'nvim/ftplugin/html.vim'
" @see 'nvim/compiler/tidy.vim'
" XQUERY
" @gf nvim/site/ftplugin/xquery.vim
" @gf nvim/site/compiler/xqm.vim

" let g:gista#client#use_git_config_github_user = 1
if !exists('g:loaded_accio')
  finish
endif

" SIGNS

" execute "sign define AccioError text=\u276f"
" execute "sign define AccioWarning text=\u276f"

" highlight! link AccioErrorSign ErrorMsg
" highlight! link AccioWarningSign WarningMsg

" h quickfix-functions
" h quickfix
" h quickfix-ID
" h :cex
" h :cadde
" h :clist list quickfix valid errors
" also
" h: clist! +3 qo
" h :cdo  go to each line exec command
" h :cfdo  go to each file exec command

" Mappings 
"  defaults 
" [w next
" ]w previous

" map [w <Plug>AccioPrevWarning
" map ]w <Plug>AccioNextWarning
" map ]w <Plug>AccioNextWarning

" open  qf window
" close qf window
" cbo p

" map ]f cnf<CR>
" map ]l cpf<CR>
" Status line
" map [w <Plug>AccioPrevWarning

" augroup init_accio
"   autocmd!
"   autocmd BufWritePost * if exists("b:accio") | call accio#accio(b:accio) | endif
" augroup END

