" --------------------------------
"   FASTER EDITING
" --------------------------------

" skip one character in insert mode
inoremap <C-l> <C-o>a

" center view on current line
inoremap <C-k> <C-o>zz

" --------------------------------
"   AUTOCOMPLETION
" --------------------------------

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

" --------------------------------
"   MISC
" --------------------------------

" update config
nnoremap <localleader>cu :source $MYVIMRC<CR>
