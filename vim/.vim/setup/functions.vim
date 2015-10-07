" Make directories if none exists

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

function! NewNote()
	execute 'edit' fnameescape(strftime("www/posts/notes/n%Y-%m-%d_%H-%M.md"))
endfunction
	
	

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

function! UProjectNewPost()
  execute ':Unite -start-insert file/new:'.ProjectRootGuess().'/www/posts/articles/'
endfunction  

function! UProjectNewNote()
execute ':Unite -immediately file/new:'.strftime("www/posts/notes/n%Y-%m-%dT%H-%M.md")
endfunction 
 
function! UProjectExplorer()
 ":VimFiler [{options}...] [[{source-name}:]{path}]
  execute ':VimFilerExplorer:'.ProjectRootGuess().'/'
endfunction


function! UProjectMostRecentlyUsed()
 "
  execute ':Unite -start-insert file_mru:'.ProjectRootGuess().'/'
endfunction
