# Dependencies
* GNU [`emacs`](https://www.archlinux.org/packages/extra/x86_64/emacs/)

# Installation
* `~/.emacs.d/`: emacs home config

# Usage
## org-config file
* config is stored as an org document
  * all of the `emacs-lisp` src blocks are loaded on startup
* `~/.emacs.d/conf.org`

## daemon
* emacs is automatically started as daemon
* connect with `emacsclient -cq`

### automatically restart
* script in `~/.emacs.d/launch-daemon.sh`
* when the daemon is shut down, always start a new daemon
* when exit code 123 is returned, don't start new daemon
