" --------------------------------
"   FASTER EDITING
" --------------------------------

" skip one character in insert mode
inoremap <C-l> <C-o>a

" center view on current line
inoremap <C-k> <C-o>zz

" line scrolling
inoremap <C-e> <C-o><C-e>
inoremap <C-y> <C-o><C-y>

" --------------------------------
"   MISC
" --------------------------------

" update config
nnoremap <localleader>cu :source $MYVIMRC<CR>
