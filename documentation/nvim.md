# Installation
## Dependencies
* [vim-plug](https://github.com/junegunn/vim-plug)
* [Powerline Fonts](https://github.com/powerline/fonts)
* [arduino](https://www.archlinux.org/packages/community/x86_64/arduino/=)
* [screen](https://www.archlinux.org/packages/extra/x86_64/screen/)

## Install neovim-config
* Link/copy `init.vim` into `~/.config/nvim/`
* Install missing vim-plug plugins (`:PlugClean`, `:UpdateRemotePlugins`, `.PlugInstall`)
* Restart neovim for the changes to take effect.

# Usage
*All* vim-plug commands and "enable-plugin-on-startup"-commands go into `config/01-plugins.vim` (needed to ensure correct load order).

Any other config file should follow this naming convention: `<any number between 02 and 99>-<descriptive name>.vim` e.g. `03-gitIntegration.vim`.

## The numbers in the file names in `config/`
The numbers aren't inportant, they only specify the order neovim is going to load the files. The numbers range from `01` to `99`. If two (or more) files have the same number, it just tells neovim the files have the same priority to be loaded.

The *only* important number on a file is `01-plugins.vim` because you want to make sure the plugins are loaded before you execute any plugin-specific commands.

Also, you *do not* want the prefix `01` at *any* file except for the `01-plugins.vim` file!

# Tips & Tricks
## Updating config from within neovim
`<localleader>cu` reads in the config files another time.

## Autocompletion
* `<C-N>`: default vim autocompletion (next item)
* `<C-P>`: default vim autocompletion (previous item)
* `<C-X><C-N>`: limits to file only
* `<C-X><C-F>`: only filenames

## Fuzzy File Finder
* `:find <file you're looking for>`
* `:find *<part of file name>` (fuzzy file find)

## Using Folds
* `zo`/`zO`: open a fold
* `zc`/`zC`: close a fold
* `za`/`zA`: toggle a fold
* `zM`: close all folds
* `zR`: open all folds

*Note:* Uppercase letters do a recursive operation.

## Arduino IDE
[vim-arduino](https://github.com/stevearc/vim-arduino) is used for arduino syntax highlighting and compilation

* `<localleader>av`: verify the current sketch
* `<localleader>au`: upload the current sketch
* `<localleader>as`: open serial monitor using screen
* `<localleader>ak`: kills serial connection (needed before another upload)
