" --------------------------------
"   TABSTOPS
" --------------------------------

" set tabs as 4 spaces
set tabstop=4

" the size of an indent
set shiftwidth=4

" insert spaces instead of tab characters
set softtabstop=0

" uses spaces instead of tabs in insert mode
set expandtab

set smarttab

" --------------------------------
"   THEME SETTINGS
" --------------------------------

" ron theme
set background=dark
colorscheme default

" enable relative linenumbers
set number relativenumber

" better line wrapping
" doesn't break words
set linebreak
"
" --------------------------------
"   MISC
" --------------------------------

" create default folds
" e.g. from '{' to '}'
set foldmethod=syntax

" see more lines while scrolling below / above the cursor
set scrolloff=5

" search in every subdirectory
set path+=**

" command to source config file
nnoremap <buffer> <localleader>cu :source $MYVIMRC<CR><CR>
