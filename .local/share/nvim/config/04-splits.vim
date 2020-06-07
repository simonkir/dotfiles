" open vertical splits to the right
set splitright

" open horizontal splits below
set splitbelow

" split naviagtion (single keybind instead of keychord)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" horizontal split to vertical split
nnoremap <localleader>sv <C-w>t<C-w>H

" vertival split to horizontral split
nnoremap <localleader>sh <C-w>t<C-w>K

" no pipe | symbols that separate splits
set fillchars+=vert:\ 
