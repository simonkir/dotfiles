# Installation
## Dependencies
* [vim-plug](https://github.com/junegunn/vim-plug)
* [Powerline Fonts](https://github.com/powerline/fonts)

## Install neovim-config
* Clone this repo into `~/.local/share/`
* Rename the `neovim-config` directory into `nvim`
* Link/copy `init.vim` into `~/.config/nvim/`
* Run `:PlugClean` (you may need to confirm by typing `y`)
* Run `:UpdateRemotePlugins`
* Run `:PlugInstall`
* Restart neovim for the changes to take effect.

# Configure neovim
**All** vim-plug commands and "enable-plugin-on-startup"-commands go into `config/01-plugins.vim`.

Plugin-specific configurations go into an extra file in `config/`. Create a file using this naming convention:

`<any number between 02 and 99>-<descriptive name>.vim` e.g. `03-gitIntegration.vim`

unless your modifications fit into an already existing file. See the 'Tips & Tricks' section</a> if you need help on the numbers before the files.

# Tips & Tricks
## The numbers in the file names in `config/`
The numbers aren't inportant, they only specify the order neovim is going to load the files. The numbers range from `01` to `99`. If two (or more) files have the same number, it just tells neovim the files have the same priority to be loaded.

The **only** important number on a file is `01-plugins.vim` because you want to make sure the plugins are loaded before you execute any plugin-specific commands.

Also, you **do not<** want the prefix `01` at **any** file except for the `01-plugins.vim` file!

## Updating config from within neovim
`<localleader>cu` reads in the config files another time.

## Autocompletion
I use the default vim autocompletion, which can be accessed with `<C-N>`.

Browse forward and backward through the list with `<C-N>` and `<C-P>`.

### Some Useful Autocompletion Keybinds
`<C-X><C-N>`: limits to file only

`<C-X><C-F>`: only filenames

## Fuzzy File Finder
To find a file, simply type `:find <file you're looking for>`, e.g. `:find main.cpp`.

To make it fuzzy, simply use an asterisk `*`, e.g. `:find main*`.

Note: You can hit TAB to autocomplete filename/list all possible filenames.

## Using Folds
I set `foldmethod=syntax`, which automatically folds everything inside curly brackets `{ }`

### Some Useful Folding Keybinds
`zo`/`zO`: open a fold

`zc`/`zC`: close a fold

`za`/`zA`: toggle a fold


**Note on  uppercase letters:** Uppercase letters mean 'recursive', which targets every sub-fold. For example, when you have multiple folds in a fold (which you have if you set `foldmethod=syntax`), it'll open/close/toggle all folds, not just the one your cursor is on.

`zM`: close all folds

`zR`: open all folds
