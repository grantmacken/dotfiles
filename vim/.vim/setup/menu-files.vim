" PROJECT FILES AND DIRS MENU
"==============================================================================
" project function
" project mappings
" project menu
"------------------------------------------------------------------------------
" https://johnhamelink.com/2014/10/31/making-unite-use-project-root
" Build the ctrlp function, using projectroot to define the
" working directory.

function! UProjectFiles()
 "execute ':Unite  -buffer-name=files -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
  execute ':Unite  -start-insert file_rec/git:'.ProjectRootGuess().'/'
endfunction    

function! UProjectNewDir()
	execute ':Unite -start-insert directory/new:'.ProjectRootGuess().'/'
endfunction  

function! UProjectNewArticle()
  execute ':Unite -start-insert file/new:'.strftime("content/posts/articles/%Y-%m-%d-")
endfunction  

function! UProjectNewNote()
	execute ':Unite -immediately file/new:'.strftime("content/posts/notes/n%Y-%m-%dT%H-%M.md")
endfunction 
 
function! UProjectNewPage()
  execute ':Unite -start-insert file/new:'.ProjectRootGuess().'/content/pages/'
endfunction 

function! UProjectExplorer()
  execute ':VimFilerExplorer:'.ProjectRootGuess().'/'
endfunction

function! UProjectMostRecentlyUsed()
	execute ':Unite -start-insert file_mru:'.ProjectRootGuess().'/'
endfunction

let g:unite_source_menu_menus.files = {
   \ 'description' : '          files & dirs                 ⌘ [space]o',
   \}

nnoremap <silent><Leader>m :call UProjectMostRecentlyUsed()<CR>
nnoremap <silent><Leader>p :call UProjectFiles()<CR>
nnoremap <silent><Leader>K :call UProjectNewDir()<CR>
nnoremap <silent><Leader>N :call UProjectNewFile()<CR>
nnoremap <silent><Leader>na :call UProjectNewArticle()<CR>
nnoremap <silent><Leader>nn :call UProjectNewNote()<CR>
nnoremap <silent><Leader>np :call UProjectNewPage()<CR>

let g:unite_source_menu_menus.files.command_candidates = [
   \['▷ content new article                                        ⌘ ,na',
   \'call UProjectNewArticle()'],
   \['▷ most recently used files                                   ⌘ ,m',
   \'call UProjectMostRecentlyUsed()'],
   \['▷ open project files with recursive search                   ⌘ ,o',
   \'call UProjectMostRecentlyUsed()'],
   \['▷ open project files with recursive search                   ⌘ ,p',
   \'call UProjectFiles()']
  \]

nnoremap <silent>[menu]o :Unite -silent -winheight=17 -start-insert::
  \ menu:files<CR>
