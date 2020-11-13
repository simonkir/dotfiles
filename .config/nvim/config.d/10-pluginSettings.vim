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
"   WRITING
" ----------------------------------------------------------------

let g:limelight_conceal_ctermfg = 245
let g:limelight_paragraph_span = 1



" ----------------------------------------------------------------
"   MARKDOWNN
" ----------------------------------------------------------------


let g:livedown_browser = "qutebrowser"      " default browser for preview
let g:vim_markdown_math = 1                 " enable latex
let g:vim_markdown_toc_autofit = 1          " auto-shrink toc



" ----------------------------------------------------------------
"   LATEX
" ----------------------------------------------------------------

let g:tex_flavor = "tex"
let g:vimtex_view_method = "general"
