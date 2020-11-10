" create easy_align_delimiters
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif

" cpp-style alignment
" works with keywords like constexpr etc
" basic workflow:
" 'gad' to align names (note: you might want to try 'gaf', see below)
" 'ga=' to align equality signs
let g:easy_align_delimiters['d'] = {
\ 'pattern': '\(const\|constexpr\|static\)\@<! ',
\ 'left_margin': 0, 'right_margin': 0
\ }

" more cpp-specific alignment
" works with more complicated keywords
" basic workflow: if 'gad' doesn't align the names properly,
" try 'gaf'
let g:easy_align_delimiters['f'] = {
\ 'pattern': ' \ze\S\+\s*[;=]',
\ 'left_margin': 0, 'right_margin': 0
\ }

" aligns comments that begin with "//"
" comments are aligned behind the widest line of code
let g:easy_align_delimiters['c'] = {
\ 'pattern': '\/\/',
\ 'ignore_groups': ['String'],
\ 'ignore_unmatched': 0
\ }

" aligns comments that begin with '"'
" comments are aligned behind the widest line of code
let g:easy_align_delimiters['"'] = {
\ 'pattern': '\"',
\ 'ignore_groups': ['String'],
\ 'ignore_unmatched': 0,
\ }

" aligns comments that begin with '%' (latex comments)
" comments are aligned behind the widest line of code
let g:easy_align_delimiters['%'] = {
\ 'pattern': '%',
\ 'ignore_groups': ['String'],
\ 'ignore_unmatched': 0,
\ }

" aligns the cpp-output operator
" e.g. if you have a really long std::cout command
" split over several lines
let g:easy_align_delimiters['<'] = {
\ 'pattern': '<<',
\ 'ignore_groups': ['String'],
\ 'ignore_unmatched': 0
\ }
