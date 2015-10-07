
" UNITE
" 1. leader mappings
" 2  lets
" 3. MENUS
"  main menu  <space>u
"==============================================================================
" 1. LEADER and LOCAL LEADER for menus
"==============================================================================

let mapleader=','
" menu prefix key
let maplocalleader = ' '

 " Unite. The interface to rule almost everything 
    " https://github.com/joedicastro/dotfiles/tree/master/vim
"I set Unite following two different ways.
"On one hand I use it to access Unite sources via mappings with the <Leader> key
", and secondly calling Unite menus through <LocalLeader> key mappings.
"==============================================================================
" 2. LETS AND CALLS
"==============================================================================

let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
call unite#custom#profile('default', 'context', {
	\   'direction': 'dynamicbottom',
	\ })   
let g:unite_data_directory = expand($VIMPATH.'/tmp/unite')
let g:junkfile#directory = expand($VIMPATH.'/tmp/junk')
let g:neomru#file_mru_path = expand($VIMPATH.'/tmp/neomru/file')
let g:neomru#directory_mru_path = expand($VIMPATH.'/tmp/neomru/directory')

let g:unite_source_buffer_time_format = '(%Y-%m-%d %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%Y-%m-%d %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%Y-%m-%d %H:%M:%S) '

let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup -a -S'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_search_word_highlight = 1

"==============================================================================
" 3. MENUS
"==============================================================================
" menus menu  a master menu that shows all the custom menus
" the master menu gets built up by constructing custom menus
" a,b.c  a three step process
" a. define the menu
"   let g:unite_source_menu_menus.{name}
" b. define array of menu command_candidates
"   let g:unite_source_menu_menus.{name}.command_candidates = []
" c. map to LocalLeader

" menus
let g:unite_source_menu_menus = {}

" menu prefix key (for all Unite menus)
nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
"

" menus menu a master menu
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR>

"==============================================================================
" 3. Command: find a command match 
"==============================================================================
cm <c-o> <Plug>(unite_cmdmatch_complete)
