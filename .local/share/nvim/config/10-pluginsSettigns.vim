" ----------------------------------------------------------------
"   FILE EXPLORER
" ----------------------------------------------------------------

" enable plugins for netrw
filetype plugin on

" file exploration menu settings
let g:netrw_banner = 0       " remove banner at top of file listing
let g:netrw_liststyle = 3    " tree style listing
let g:netrw_altv = 1         " open vsplit to the right instead of left
let g:netrw_winsize = 15



" ----------------------------------------------------------------
"   MARKDOWNN
" ----------------------------------------------------------------

" default browser for preview
let g:livedown_browser = "qutebrowser"



" ----------------------------------------------------------------
"   LATEX
" ----------------------------------------------------------------

let g:tex_flavor = "tex"
let g:vimtex_view_method = "general"
