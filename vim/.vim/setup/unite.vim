
" UNITE
" 1. lets and calls
" 2. LEADER mappings
" 3. MENUS  mappings <space>
"  main menu  <space>u
"
"==================
" 1. LETS AND CALLS
"==================
"===============================================================================
"VimFiler   https://github.com/Shougo/vimfiler.vim/blob/master/doc/vimfiler.txt
"===============================================================================
" vimfiler needs unite
" Disable netrw.vim
let g:loaded_netrwPlugin = 1

" vimfiler behaves as default explorer
let g:vimfiler_as_default_explorer = 1
"let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = " "
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_time_format = '%m-%d-%y %H:%M:%S'
let g:vimfiler_expand_jump_to_first_child = 0

" When pressing "e" open file in new tab.
" let g:vimfiler_edit_action = 'tabopen'

" Don't ignore any files (the default is to ignore files beginning with dot).
" let g:vimfiler_ignore_pattern =
"let g:vimfiler_ignore_pattern = '\.git\|\.DS_Store\|\.pyc'

" matcher_ignore_files

call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
            \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))

let g:default_context = {
    \ 'winheight' : 15,
    \ 'update_time' : 200,
    \ 'prompt' : '>>> ',
    \ 'enable_start_insert' : 0,
    \ 'enable_short_source_names' : 0,
    \ 'marked_icon' : '✓',
    \ 'ignorecase' : 1,
    \ 'smartcase' : 1,
\ }

call unite#custom#profile('default', 'context', default_context)

" let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_enable_short_source_mes = 0
let g:unite_split_rule = 'botright'
let g:unite_data_directory = $HOME.'/.vim/tmp/unite'
let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '


let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '


let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup -a -S'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_search_word_highlight = 1


let g:junkfile#directory = expand($HOME.'/.vim/tmp/junk')
let g:neomru#file_mru_path = expand($HOME.'/.vim/tmp/neomru/file')
let g:neomru#directory_mru_path = expand($HOME.'/.vim/tmp/neomru/directory')


