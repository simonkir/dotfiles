syntax enable
" enable plugins for netrw
filetype plugin on

" error handling: E382
" apparentely, netrw sets bt when reading a new buffer to all other buffers
" quickfix: :set bt=
" apply quickfix when writing
" note: there may be a better event than BufWrite
autocmd BufWrite * :set bt=

" file exploration menu settings
let g:netrw_banner = 0        " remove directions at top of file listing
let g:netrw_liststyle=3       " tree style listing
let g:netrw_browse_split = 3  " open in new tab
let g:netrw_winsize=25        " width of window
