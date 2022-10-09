# -*- mode: gnuplot-mode -*-

reset
set term pngcairo font "Noto Serif"
set tics nomirror
set key position top right
set samples 500
set format "%g"

# one-dark color scheme #######################################################
set term pngcairo background rgb "#282c34" # black

set grid          lc rgb "#ffffff" # grey
set zeroaxis      lc rgb "#ffffff" # white
set border 3      lc rgb "#bbc2cf" # white
set tics   textcolor rgb "#bbc2cf" # white
set xlabel textcolor rgb "#bbc2cf" # white
set ylabel textcolor rgb "#bbc2cf" # white
set key    textcolor rgb "#bbc2cf" # white

set linetype 1  pt 3 ps 3 lw 2 lc rgb "#98be65" # green
set linetype 2  pt 3 ps 3 lw 2 lc rgb "#ecbe7b" # yellow
set linetype 3  pt 3 ps 3 lw 2 lc rgb "#51afef" # blue
set linetype 4  pt 3 ps 3 lw 2 lc rgb "#ff6c6b" # red
set linetype 5  pt 3 ps 3 lw 2 lc rgb "#c678dd" # magenta
set linetype 6  pt 3 ps 3 lw 2 lc rgb "#a9a1e1" # violet
set linetype 7  pt 3 ps 3 lw 2 lc rgb "#46d9ff" # cyan
set linetype 8  pt 3 ps 3 lw 2 lc rgb "#5699af" # cyan dark
set linetype 9  pt 3 ps 3 lw 2 lc rgb "#2257a0" # blue dark
set linetype 10 pt 3 ps 3 lw 2 lc rgb "#44b9b1" # teal
set linetype 11 pt 3 ps 3 lw 2 lc rgb "#dd8844" # orange
set linetype cycle 11

# note: atm, this has no use and is only
#       kept for future configuration
#set palette maxcolors 11
#set palette defined ( \
#   0  '#ff6655', \
#   1  '#dd8844', \
#   2  '#99bb66', \
#   3  '#44b9b1', \
#   4  '#ecbe7b', \
#   5  '#51afef', \
#   6  '#2257a0', \
#   7  '#c678dd', \
#   8  '#a9a1e1', \
#   9  '#46d9ff', \
#   10 '#5699af'  \
#)