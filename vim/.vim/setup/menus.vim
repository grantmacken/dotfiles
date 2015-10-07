"==============================================================================
" 3. MENUS
"==============================================================================
let mapleader=','
" menu prefix key
let maplocalleader = ' '

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
