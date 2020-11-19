" ----------------------------------------------------------------
"   FASTER EDITING
" ----------------------------------------------------------------

" skip one character in insert mode
inoremap <C-l> <C-o>a

" center view on current line
inoremap <C-k> <C-o>zz

" move line up / down
inoremap <M-k> <Esc>:m-2<CR>gi
inoremap <M-j> <Esc>:m+1<CR>gi
nnoremap <M-k> :m-2<CR>
nnoremap <M-j> :m+1<CR>

" ----------------------------------------------------------------
"   WRITING
" ----------------------------------------------------------------

" these aliases create an undo point after each
" .…,!?:– (end of sentence or clauses)
augroup textlike
    autocmd!
    autocmd FileType markdown,tex,latex,text inoremap <buffer> . .<C-g>u
    autocmd FileType markdown,tex,latex,text inoremap <buffer> … …<C-g>u
    autocmd FileType markdown,tex,latex,text inoremap <buffer> , ,<C-g>u
    autocmd FileType markdown,tex,latex,text inoremap <buffer> ! !<C-g>u
    autocmd FileType markdown,tex,latex,text inoremap <buffer> ? ?<C-g>u
    autocmd FileType markdown,tex,latex,text inoremap <buffer> : :<C-g>u
    autocmd FileType markdown,tex,latex,text inoremap <buffer> – –<C-g>u
augroup END

augroup markdown
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <CR> A<CR>
augroup END

" aliases for spell checking
nnoremap <localleader>se :setlocal spell<CR>:setlocal spelllang=en_us<CR>
nnoremap <localleader>sd :setlocal spell<CR>:setlocal spelllang=de_de<CR>
nnoremap <localleader>ss :setlocal nospell<CR>



" ----------------------------------------------------------------
"   AUTOCOMPLETION
" ----------------------------------------------------------------

" either insert <Tab> or open autocompletion
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-P>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" scroll back in autocompletion
inoremap <S-Tab> <C-N>



" ----------------------------------------------------------------
"   SPLITS
" ----------------------------------------------------------------

" split navigation (single keybind instead of keychord)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" horizontal split to vertical split
nnoremap <localleader>sv <C-w>t<C-w>H

" vertical split to horizontal split
nnoremap <localleader>sh <C-w>t<C-w>K



" ----------------------------------------------------------------
"   TABS
" ----------------------------------------------------------------

nnoremap <C-t> :tabnew<CR>:e 
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <C-c> :q<CR>
nnoremap <localleader>tl :tabmove +1<CR>
nnoremap <localleader>th :tabmove -1<CR>



" --------------------------------
"   PLUGIN-SPECIFIC
" --------------------------------

nnoremap <localleader>wg :Goyo<CR>
nnoremap <localleader>wl :Limelight!!<CR>
nnoremap <localleader>mm :LivedownToggle<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)



" ----------------------------------------------------------------
"   MISC
" ----------------------------------------------------------------

" update config
nnoremap <localleader>cu :source $MYVIMRC<CR>
nnoremap <Space> za
