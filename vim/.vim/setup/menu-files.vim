
" FILES AND DIRS MENU
"==============================================================================

let g:unite_source_menu_menus.files = {
    \ 'description' : '          files & dirs                 ⌘ [space]o',
    \}

let g:unite_source_menu_menus.files.command_candidates = [
    \['▷ most recently used files                                   ⌘ ,m',
        \'call UProjectMostRecentlyUsed()'],
    \['▷ open project files with recursive search                   ⌘ ,o',
        \'call UProjectFiles()'],
    \['▷ explorer view with vimfiler                                ⌘ ,e',
        \'call UProjectExplorer()']
    \]

nnoremap <silent>[menu]o :Unite -silent -winheight=17 -start-insert::
            \ menu:files<CR>
