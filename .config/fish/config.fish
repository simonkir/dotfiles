# * env vars
set -gx WINIT_X11_SCALE_FACTOR 1
set -gx EDITOR "emacsclient -tq"
set -gx VISUAL "emacsclient -cq"

# * aliases
abbr -a "la" "ls -a"
abbr -a "ll" "ls -lh"
abbr -a "lla" "ls -lha"
abbr -a "mv" "mv -i"
abbr -a "rm" "rm -I"
abbr -a "gspdf" "gs -q -dNOPAUSE -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook"
abbr -a "magick" "magick -density 300"

function mkcd
    mkdir $argv[1]
    cd $argv[1]
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# * visuals
fish_config prompt choose scales
fish_config theme choose Dracula

function fish_greeting
    hyfetch
end
