" Make directories if none exists

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" https://johnhamelink.com/2014/10/31/making-unite-use-project-root
" Build the ctrlp function, using projectroot to define the
" working directory.

function! UProjectFiles()
 "execute ':Unite  -buffer-name=files -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
  execute ':Unite  -start-insert file_rec/async:'.ProjectRootGuess().'/'
endfunction

function! UProjectExplorer()
 ":VimFiler [{options}...] [[{source-name}:]{path}]
  execute ':VimFiler:'.ProjectRootGuess().'/'
endfunction


function! UProjectMostRecentlyUsed()
 "
  execute ':Unite -start-insert file_mru:'.ProjectRootGuess().'/'
endfunction
