" error handling: E382
" apparentely, netrw sets bt when reading a new buffer to all other buffers
" quickfix: :set bt=
" apply quickfix when writing
" note: there may be a better event than BufWrite
autocmd BufWrite * :set bt=
