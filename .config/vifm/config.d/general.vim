" Command used to edit files in various contexts.  The default is vim.
" If you would like to use another vi clone such as Elvis or Vile
" you will need to change this setting.
set vicmd=nvim

" This makes vifm perform file operations on its own instead of relying on
" standard utilities like `cp`.  While using `cp` and alike is a more universal
" solution, it's also much slower when processing large amounts of files and
" doesn't support progress measuring.
set syscalls

" Trash Directory
" The default is to move files that are deleted with dd or :d to
" the trash directory.  If you change this you will not be able to move
" files by deleting them and then using p to put the file in the new location.
" I recommend not changing this until you are familiar with vifm.
" This probably shouldn't be an option.
set trash

" This is how many directories to store in the directory history.
set history=100

" Automatically resolve symbolic links on l or Enter.
set nofollowlinks

" With this option turned on you can run partially entered commands with
" unambiguous beginning using :! (e.g. :!Te instead of :!Terminal or :!Te<tab>).
" set fastrun

" Natural sort of (version) numbers within text.
set sortnumbers

" Maximum number of changes that can be undone.
set undolevels=100

" Use Vim's format of help file (has highlighting and "hyperlinks").
" If you would rather use a plain text help file set novimhelp.
set vimhelp

" If you would like to run an executable file when you
" press return on the file name set this.
set norunexec

" Selected color scheme
colorscheme Default

" Format for displaying time in file list. For example:
" TIME_STAMP_FORMAT=%m/%d-%H:%M
" See man date or man strftime for details.
set timefmt=%m/%d\ %H:%M

" Show list of matches on tab completion in command-line mode
set wildmenu

" Display completions in a form of popup with descriptions of the matches
set wildstyle=popup

" Display suggestions in normal, visual and view modes for keys, marks and
" registers (at most 5 files).  In other view, when available.
set suggestoptions=normal,visual,view,otherpane,keys,marks,registers

" Ignore case in search patterns unless it contains at least one uppercase letter
set ignorecase
set smartcase

" Don't highlight search results automatically
set nohlsearch

" Use increment searching (search while typing)
set incsearch

" Try to leave some space from cursor to upper/lower border in lists
set scrolloff=4

" Don't do too many requests to slow file systems
if !has('win')
    set slowfs=curlftpfs
endif

" Set custom status line look
set statusline="  Hint: %z%= %A %10u:%-7g %15s %20d  "

set number
set relativenumber

colo palenight

" What should be saved automatically between vifm sessions.  Drop "savedirs"
" value if you don't want vifm to remember last visited directories for you.
set vifminfo=dhistory,savedirs,chistory,state,tui,shistory,
    \phistory,fhistory,dirstack,registers,bookmarks,bmarks

" ------------------------------------------------------------------------------


" Various customization examples

" Use ag (the silver searcher) instead of grep
"
" set grepprg='ag --line-numbers %i %a %s'

" Add additional place to look for executables
"
" let $PATH = $HOME.'/bin/fuse:'.$PATH

" Block particular shortcut
"
" nnoremap <left> <nop>

" Export IPC name of current instance as environment variable and use it to
" communicate with the instance later.
"
" It can be used in some shell script that gets run from inside vifm, for
" example, like this:
"     vifm --server-name "$VIFM_SERVER_NAME" --remote +"cd '$PWD'"
"
" let $VIFM_SERVER_NAME = v:servername
