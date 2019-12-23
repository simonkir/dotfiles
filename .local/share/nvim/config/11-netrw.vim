syntax enable
" enable plugins for netrw
filetype plugin on

" error handling: E382
" apparentely, netrw sets bt when reading a new buffer to all other buffers
" quickfix: :set bt=
" apply quickfix when writing
" note: there may be a better event than BufWrite
autocmd BufWrite * :set bt=

" set banner to be visible
let g:netrw_banner = 1

" set list style: detailed
let g:netrw_liststyle = 1
