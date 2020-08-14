call plug#begin('~/.local/share/nvim/plugged')

" insert all plugins below this line

Plug 'vim-airline/vim-airline'        " status bar
Plug 'vim-airline/vim-airline-themes' " status bar themes

Plug 'mhinz/vim-startify'             " fancy start screen
Plug 'vifm/vifm.vim'                  " vifm file manager

Plug 'jiangmiao/auto-pairs'           " auto-close parentheses
Plug 'tpope/vim-surround'             " edit parentheses
Plug 'junegunn/vim-easy-align'        " easy alignment

Plug 'neomake/neomake'                " error highlighting / linting

Plug 'lervag/vimtex'		          " latex support
Plug 'iamcco/markdown-preview.vim'    " markdown preview
Plug 'stevearc/vim-arduino'           " arduino compatibility

" insert all plugins above this line

call plug#end()

" enable linter by default
call neomake#configure#automake('nw', 750)
