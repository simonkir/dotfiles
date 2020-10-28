# qutebrowser
config file: `~/.config/qutebrowser/config.py`

# installation
* [`qutebrowser (community)`](https://www.archlinux.org/packages/community/any/qutebrowser/)
* clone [dracula theme repo](https://github.com/dracula/qutebrowser) into `~/.config/qutebrowser/`

# tips and tricks
## ad-blocking
* run `:adblock-update`
* doesn't work on all sites though

### watching youtube without ads
* use binding `Z` (current url) or `z` (hint) to watch videos in an external video player

## improved keybinds
* `xb`: toggles main bar
* `xt`: toggles tab bar
* `F`: hints input fields only
* `I`: insert in first input field

### other useful keybinds
* `;f`: open hint in foreground tab
* `;b`: open hint in background tab
* `;p`: open hint in private tab
* `;y`: yank hinted url to clipboard
* `;r`: rapid hinting (open several hints in background tabs)

## custom startpage
the custom startpage needs to be `~/.config/qutebrowser/startpage/index.html` (linking also possible)
