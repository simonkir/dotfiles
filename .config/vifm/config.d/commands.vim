" :com[mand][!] command_name action
" The following macros can be used in a command
" %a is replaced with the user arguments.
" %c the current file under the cursor.
" %C the current file under the cursor in the other directory.
" %f the current selected file, or files.
" %F the current selected file, or files in the other directory.
" %b same as %f %F.
" %d the current directory name.
" %D the other window directory name.
" %m run the command in a menu window

command! df df -h %m 2> /dev/null
command! run !! ./%f
command! make !!make %a
command! mkcd :mkdir %a | cd %a
command! tedit :touch %a | edit %a " short version -> :te
command! reload :write | restart
