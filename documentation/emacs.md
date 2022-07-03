# Usage
## daemon
* emacs is automatically started as daemon
* connect with `emacsclient -cq`

### auto-restart
* script in `~/.emacs.d/launch-daemon.sh`
* when the daemon is shut down, always start a new daemon
* when exit code 123 is returned, don't start new daemon
