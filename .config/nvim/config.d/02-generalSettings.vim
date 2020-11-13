" ----------------------------------------------------------------
"   TABSTOPS
" ----------------------------------------------------------------

set tabstop=4     " set tabs as 4 spaces
set shiftwidth=4  " the size of an indent
set softtabstop=0 " insert spaces instead of tab characters
set expandtab     " uses spaces instead of tabs in insert mode
set smarttab



" ----------------------------------------------------------------
"   THEME SETTINGS
" ----------------------------------------------------------------

set background=dark       " ron theme
colorscheme default
set number relativenumber " enable relative linenumbers
set linebreak             " better line wrapping, doesn't break words
syntax enable             " syntax highlighting



" ----------------------------------------------------------------
"   SPLITS
" ----------------------------------------------------------------

set splitright " open vertical splits to the right
set splitbelow " open horizontal splits below

" no pipe | symbols that separate splits
set fillchars+=vert:\ 



" ----------------------------------------------------------------
"   MISC
" ----------------------------------------------------------------

set mouse=a           " enable mouse support
set foldmethod=indent " create default folds, e.g. from '{' to '}'
set scrolloff=5       " see more lines while scrolling below / above the cursor
set path+=**          " search in every subdirectory
set autochdir         " change vim working dir when editing other files
set cole=2            " hide formatting operator, e. g. *italics*
