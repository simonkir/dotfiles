" The file type is for the default programs to be used with
" a file extension.
" :filetype pattern1,pattern2 defaultprogram,program2
" :fileviewer pattern1,pattern2 consoleviewer
" The other programs for the file type can be accessed with the :file command
" The command macros %f, %F, %d, %F may be used in the commands.
" The %a macro is ignored.  To use a % you must put %%.

" For automated FUSE mounts, you must register an extension with :file[x]type
" in one of following formats:
"
" :filetype extensions FUSE_MOUNT|some_mount_command using %SOURCE_FILE and %DESTINATION_DIR variables
" %SOURCE_FILE and %DESTINATION_DIR are filled in by vifm at runtime.
" A sample line might look like this:
" :filetype *.zip,*.jar,*.war,*.ear FUSE_MOUNT|fuse-zip %SOURCE_FILE %DESTINATION_DIR
"
" :filetype extensions FUSE_MOUNT2|some_mount_command using %PARAM and %DESTINATION_DIR variables
" %PARAM and %DESTINATION_DIR are filled in by vifm at runtime.
" A sample line might look like this:
" :filetype *.ssh FUSE_MOUNT2|sshfs %PARAM %DESTINATION_DIR
" %PARAM value is filled from the first line of file (whole line).
" Example first line for SshMount filetype: root@127.0.0.1:/
"
" You can also add %CLEAR if you want to clear screen before running FUSE
" program.

" Pdf
filextype *.pdf zathura %c %i &, apvlv %c, xpdf %c
fileviewer *.pdf pdftotext -nopgbrk %c -

" Audio
filetype *.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus
       \ {Play using ffplay}
       \ ffplay -nodisp -autoexit %c,
       \ {Play using MPlayer}
       \ mplayer %f,
fileviewer *.mp3 mp3info
fileviewer *.flac soxi

" Video
filextype *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
         \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
         \*.as[fx]
        \ {View using ffplay}
        \ ffplay -fs -autoexit %f,
        \ {View using Dragon}
        \ dragon %f:p,
        \ {View using mplayer}
        \ mplayer %f,
fileviewer *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
          \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
          \*.as[fx]
         \ ffprobe -pretty %c 2>&1

" Web
filextype *.html,*.htm
        \ {Open with dwb}
        \ dwb %f %i &,
        \ {Open with qutebrowser}
        \ qutebrowser %f &,
        \ {Open with firefox}
        \ firefox %f &,
        \ {Open with uzbl}
        \ uzbl-browser %f %i &,
filetype *.html,*.htm links, lynx

" Images
filextype *.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm
        \ {View in sxiv}
        \ sxiv %f %i &,
        \ {View in gpicview}
        \ gpicview %c %i &,
        \ {View in shotwell}
        \ shotwell %i &,
fileviewer *.bmp,*.gif,*.xpm
         \ identify %f

" image previews
fileviewer *.jpg,*.jpeg,*.png
           \ vifmimg draw %px %py %pw %ph %c
           \ %pc
           \ vifmimg clear

" graphic programs
filextype *.kra krita %f %i &
filextype *.xcf gimp %f %i &
filextype *.blend blender %f %i &

" Office files
filextype *.odt,*.odg,*.ods,*.doc,*.docx,*.xls,*.xlsx,*.odp,*.pptx libreoffice %f %i &
filextype *.xopp xournalpp %f %i &
fileviewer *.doc catdoc %c
fileviewer *.docx docx2txt.pl %f -

" -----------------------------------------
" less common filetypes
" -----------------------------------------

" FuseZipMount
filetype *.zip,*.jar,*.war,*.ear,*.oxt,*.apkg
       \ {View contents}
       \ 7z l | less,
       \ {Extract here}
       \ tar -xf %c,
fileviewer *.zip,*.jar,*.war,*.ear,*.oxt 7z l

" PostScript
filextype *.ps,*.eps,*.ps.gz
        \ {View in zathura}
        \ zathura %f,
        \ {View in gv}
        \ gv %c %i &,

" Djvu
filextype *.djvu
        \ {View in zathura}
        \ zathura %f,
        \ {View in apvlv}
        \ apvlv %f,

" Object
filetype *.o nm %f | less

" Man page
filetype *.[1-8] man ./%c
fileviewer *.[1-8] man ./%c | col -b

" OpenRaster
filextype *.ora
        \ {Edit in MyPaint}
        \ mypaint %f,

" Mindmap
filextype *.vym
        \ {Open with VYM}
        \ vym %f %i &,

" MD5
filetype *.md5
       \ {Check MD5 hash sum}
       \ md5sum -c %f %S,

" SHA1
filetype *.sha1
       \ {Check SHA1 hash sum}
       \ sha1sum -c %f %S,

" SHA256
filetype *.sha256
       \ {Check SHA256 hash sum}
       \ sha256sum -c %f %S,

" SHA512
filetype *.sha512
       \ {Check SHA512 hash sum}
       \ sha512sum -c %f %S,

" GPG signature
filetype *.asc
       \ {Check signature}
       \ !!gpg --verify %c,

" Torrent
filetype *.torrent ktorrent %f %i &
fileviewer *.torrent dumptorrent -v %c

" ArchiveMount
filetype *.tar,*.tar.bz2,*.tbz2,*.tgz,*.tar.gz,*.tar.xz,*.txz
       \ {Mount with archivemount}
       \ FUSE_MOUNT|archivemount %SOURCE_FILE %DESTINATION_DIR,
fileviewer *.tgz,*.tar.gz tar -tzf %c
fileviewer *.tar.bz2,*.tbz2 tar -tjf %c
fileviewer *.tar.txz,*.txz xz --list %c
fileviewer *.tar tar -tf %c

" Rar2FsMount and rar archives
filetype *.rar
       \ {Mount with rar2fs}
       \ FUSE_MOUNT|rar2fs %SOURCE_FILE %DESTINATION_DIR,
fileviewer *.rar unrar v %c

" IsoMount
filetype *.iso
       \ {Mount with fuseiso}
       \ FUSE_MOUNT|fuseiso %SOURCE_FILE %DESTINATION_DIR,

" SshMount
filetype *.ssh
       \ {Mount with sshfs}
       \ FUSE_MOUNT2|sshfs %PARAM %DESTINATION_DIR %FOREGROUND,

" FtpMount
filetype *.ftp
       \ {Mount with curlftpfs}
       \ FUSE_MOUNT2|curlftpfs -o ftp_port=-,,disable_eprt %PARAM %DESTINATION_DIR %FOREGROUND,

" Fuse7z and 7z archives
filetype *.7z
       \ {Mount with fuse-7z}
       \ FUSE_MOUNT|fuse-7z %SOURCE_FILE %DESTINATION_DIR,
fileviewer *.7z 7z l %c

" TuDu files
filetype *.tudu tudu -f %c

" Qt projects
filextype *.pro qtcreator %f %i &

" Directories
filextype */
        \ {View in thunar}
        \ Thunar %f %i &,

" Syntax highlighting in preview
"
" Explicitly set highlight type for some extensions
"
" 256-color terminal
" fileviewer *.[ch],*.[ch]pp highlight -O xterm256 -s dante --syntax c %c
" fileviewer Makefile,Makefile.* highlight -O xterm256 -s dante --syntax make %c
"
" 16-color terminal
" fileviewer *.c,*.h highlight -O ansi -s dante %c
"
" Or leave it for automatic detection
"
" fileviewer *[^/] pygmentize -O style=monokai -f console256 -g

" Displaying pictures in terminal
"
" fileviewer *.jpg,*.png shellpic %c

" Open all other files with default system programs (you can also remove all
" :file[x]type commands above to ensure they don't interfere with system-wide
" settings).  By default all unknown files are opened with 'vi[x]cmd'
" uncommenting one of lines below will result in ignoring 'vi[x]cmd' option
" for unknown file types.
" For *nix:
" filetype * xdg-open
" For OS X:
" filetype * open
" For Windows:
" filetype * start, explorer
"

" GETTING ICONS TO DISPLAY IN VIFM
" You need the next 14 lines!
" file type icons
set classify='  :dir:/,  :exe:,  :reg:,  :link:'
" various file names
set classify+='  ::../::,  ::*.sh::,  ::*.[hc]pp::,  ::*.[hc]::,  ::/^copying|license$/::,  ::.git/,,*.git/::, ::*.epub,,*.fb2,,*.djvu::,  ::*.pdf::,  ::*.htm,,*.html,,**.[sx]html,,*.xml::'
" archives
set classify+='  ::*.7z,,*.ace,,*.arj,,*.bz2,,*.cpio,,*.deb,,*.dz,,*.gz,,*.jar,,*.lzh,,*.lzma,,*.rar,,*.rpm,,*.rz,,*.tar,,*.taz,,*.tb2,,*.tbz,,*.tbz2,,*.tgz,,*.tlz,,*.trz,,*.txz,,*.tz,,*.tz2,,*.xz,,*.z,,*.zip,,*.zoo::'
" images
set classify+='  ::*.bmp,,*.gif,,*.jpeg,,*.jpg,,*.ico,,*.png,,*.ppm,,*.svg,,*.svgz,,*.tga,,*.tif,,*.tiff,,*.xbm,,*.xcf,,*.xpm,,*.xspf,,*.xwd::'
" audio
set classify+='  ::*.aac,,*.anx,,*.asf,,*.au,,*.axa,,*.flac,,*.m2a,,*.m4a,,*.mid,,*.midi,,*.mp3,,*.mpc,,*.oga,,*.ogg,,*.ogx,,*.ra,,*.ram,,*.rm,,*.spx,,*.wav,,*.wma,,*.ac3::'
" media
set classify+='  ::*.avi,,*.ts,,*.axv,,*.divx,,*.m2v,,*.m4p,,*.m4v,,.mka,,*.mkv,,*.mov,,*.mp4,,*.flv,,*.mp4v,,*.mpeg,,*.mpg,,*.nuv,,*.ogv,,*.pbm,,*.pgm,,*.qt,,*.vob,,*.wmv,,*.xvid::'
" office files
set classify+='  ::*.doc,,*.docx::,  ::*.xls,,*.xls[mx]::,  ::*.pptx,,*.ppt::'
