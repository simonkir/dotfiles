for f in split(glob('~/.local/share/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor
