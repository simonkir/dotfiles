# Installation
## Dependencies
* [vim-plug](https://github.com/junegunn/vim-plug)
* [Powerline Fonts](https://github.com/powerline/fonts)
* [`npm (community)`](https://www.archlinux.org/packages/community/any/npm/)

## Install neovim-config
* Link/copy `init.vim` into `~/.config/nvim/`
* `:PlugClean`, `:UpdateRemotePlugins`, `:PlugInstall`

# Usage
* `config/01-plugins.vim`: all vim-plug and plugin-enabling commands
* `config/0n-xyzabc.vim`: nvim-specific configuration
* `config/nn-xyzabc.vim`: plugin-specifig / other configuration

## `nn`-prefix
* specifies load order on nvim startup

Note: `01`-prefix is reserved for `01-plugins.vim`. No other config file must therefore use it!

# Tips & Tricks
## Updating config from within neovim
`<localleader>cu` reads in the config files another time.

## Autocompletion
* `<TAB>`: default vim autocompletion (previous item)
* `<S-TAB>`: default vim autocompletion (next item)
* `<C-X><C-F>`: only filenames

## Using Folds
* `zo`/`zO`: open a fold
* `zc`/`zC`: close a fold
* `za`/`zA`: toggle a fold
* `zM`: close all folds
* `zR`: open all folds
