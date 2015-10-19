" Plugin Settings
"---------------------------------------------------------

" Colorscheme {{{
syntax enable                  " enable the syntax highlight
set background=dark           " set a dark background
set t_Co=256                   " 256 colors for the terminal
"let g:seoul256_background = 239

" colorscheme seoul256-lightL:
colorscheme seoul256
" " }}}
" Airline, tmuline statusline and tabline {{{
" just use airline
let airline_theme='ubaryd'
let airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1        " enable tabline list
let g:airline#extensions#tabline#buffer_nr_show = 1  " show  buffer number
" let g:airline#extensions#tabline#buffer_nr_format = '%s: '
" let g:airline#extensions#tabline#fnametruncate = 10
let g:airline#extensions#tabline#fnamemod = ':t'  " Show just the filename
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" let g:airline_section_x = '%{PencilMode()}':

let g:tmuxline_powerline_separators = 0

" let g:tmuxline_preset = {
"    \'a'    : '#S',
"    \'win'  : ['#I', '#W'],
"    \'cwin' : ['#I', '#P','#W', '#F'],
"    \'y'    : ['%R','%a','%Y'],
"    \'z'    : '#H'}

" }}}

" vim-prosession {{{
let g:prosession_tmux_title = 1
let g:prosession_on_startup = 1
let g:prosession_default_session = 0

" }}}

" skeleton templates {{{
" default template_dir ~/.vim/templates
" function! g:skeleton_replacements.CREATED()
" 	return "xxx"
" endfunction
" " }}}
