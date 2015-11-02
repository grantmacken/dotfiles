let g:unite_source_menu_menus.navigation = {
    \ 'description' : '     navigate by buffers, tabs & windows
        \                   ⌘ [space]b',
    \}

" re map <silent> [unite]i :<C-u>Unite file_rec/git<CR>
let g:unite_source_menu_menus.navigation.command_candidates = [
    \['▷ buffers                                                          ⌘ ,b',
        \'Unite buffer'],
    \['▷ browse next buffer                                              ⌘ ,bf',
        \'BufSurfFoward'],
    \['▷ browse prev buffer                                              ⌘ ,bb',
        \'BufSurfBack'],
    \['▷ first buffer                                                         ',
        \'bfirst'],
    \['▷ next modified buffer                                                 ',
        \'bmodified'],
    \['▷ delete buffer                                                        ',
        \'bdelete'],
    \]
nnoremap <silent>[menu]b :Unite -silent menu:navigation<CR>
