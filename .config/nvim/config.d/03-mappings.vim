" ----------------------------------------------------------------
"   FASTER EDITING
" ----------------------------------------------------------------

" skip one character in insert mode
inoremap <C-l> <C-o>a

" center view on current line
inoremap <C-k> <C-o>zz



" ----------------------------------------------------------------
"   WRITING
" ----------------------------------------------------------------

" these aliasses create an undo point after each
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

" split naviagtion (single keybind instead of keychord)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" horizontal split to vertical split
nnoremap <localleader>sv <C-w>t<C-w>H

" vertival split to horizontral split
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
