# Installation
## Dependencies
<ul>
<li>
<b>vim-plug</b>
<br>
vim-plug is the plugin manager used.
<a href="https://github.com/junegunn/vim-plug">Install vim-plug</a>
<br>
<i>If you're unfamiliar with 'vim-plug', I definitely recommend reading the <a href="https://github.com/junegunn/vim-plug/wiki/tutorial">official tutorial</a>.</i>
</li>
<li>
<b>Powerline Fonts</b>
<br>
Powerline Fonts are used to display the triangles in the status bar.
<a href="https://github.com/powerline/fonts">Install Powerline Fonts</a>
<br>
</li>
</ul>

## Install neovim-config
Clone this repo into `~/.local/share/`
<br>
Rename the `neovim-config` directory into `nvim`
<br>
Link/copy `init.vim` into `~/.config/nvim/`
<br>
Run `:PlugClean` (you may need to confirm by typing `y`)
<br>
Run `:UpdateRemotePlugins`
<br>
Run `:PlugInstall`
<br>
Restart neovim for the changes to take effect.

# Configure neovim
<b>All</b> vim-plug commands and "enable-plugin-on-startup"-commands go into `config/01-plugins.vim`.
<br>
Plugin-specific configurations go into an extra file in `config/`. Create a file using this naming convention:
<br>`<any number between 02 and 99>-<descriptive name>.vim` e.g. `03-gitIntegration.vim` unless your modifications fit into an already existing file. See the 'Tips & Tricks' section</a> if you need help on the numbers before the files.

# Tips & Tricks
## The numbers in the file names in `config/`
The numbers aren't inportant, they only specify the order neovim is going to load the files. The numbers range from `01` to `99`. If two (or more) files have the same number, it just tells neovim the files have the same priority to be loaded.
<br>
<br>
The <b>only</b> important number on a file is `01-plugins.vim` because you want to make sure the plugins are loaded before you execute any plugin-specific commands.
<br>
Also, you <b>do not</b> want the prefix `01` at <b>any</b> file except for the `01-plugins.vim` file!

## Updating config from within neovim
`<localleade>cu` reads in the config files another time.

## Autocompletion
I use the default vim autocompletion, which can be accessed with `<C-N>`.
<br>
Browse forward and backward through the list with `<C-N>` and `<C-P>`.
<br>
### Some Useful Autocompletion Keybinds
`<C-X><C-N>`: limits to file only
<br>
`<C-X><C-F>`: only filenames

## Fuzzy File Finder
To find a file, simply type `:find <file you're looking for>`, e.g. `:find main.cpp`.
<br>
To make it fuzzy, simply use an asterisk `*`, e.g. `:find main*`.
<br>
Note: You can hit TAB to autocomplete filename/list all possible filenames.

## Using Folds
I set `foldmethod=syntax`, which automatically folds everything inside curly brackets `{ }`
<br>
### Some Useful Folding Keybinds
`zo`/`zO`: open a fold
<br>
`zc`/`zC`: close a fold
<br>
`za`/`zA`: toggle a fold
<br>
<br>
**Note on  uppercase letters:** Uppercase letters mean 'recursive', which targets every sub-fold. For example, when you have multiple folds in a fold (which you have if you set `foldmethod=syntax`), it'll open/close/toggle all folds, not just the one your cursor is on.
<br>
<br>
`zM`: close all folds
<br>
`zR`: open all folds
