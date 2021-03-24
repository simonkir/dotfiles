# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

###############################################################################
#                              COOKIE / JS STUFF                              #
###############################################################################

config.load_autoconfig()
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version} Edg/{upstream_browser_version}', 'https://accounts.google.com/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

###############################################################################
#                                   KEYBINDS                                  #
###############################################################################

# scrolling ###################################################################
config.bind('j', 'run-with-count 4 scroll down')
config.bind('k', 'run-with-count 4 scroll up')
c.scrolling.smooth = True

# tabs & windows ##############################################################
config.bind('<Ctrl-t>', 'open -t ~/.config/qutebrowser/startpage/index.html') # open startpage in new tab
config.bind('t', 'set-cmd-text -s :open -t') # open link in new tab
config.bind('O', 'set-cmd-text -s :open -p') # open link in private mode
config.bind('D', 'close')
c.tabs.last_close = "close"

# hinting #####################################################################
config.bind('F', 'hint inputs')                        # hints inputs only (replaces hint and open in new tab, alt binding: ;f)
config.bind('I', 'hint inputs --first')                # insert mode in first field, same as gi
config.bind(';p', 'hint links run open -p {hint-url}') # open hint in private tab

# tab & status bars ###########################################################
config.bind('xb', 'config-cycle statusbar.show never always')
config.bind('xt', 'config-cycle tabs.show never always')
config.bind(',d', 'config-cycle content.user_stylesheets dark-mode.css \"\"')

# watch videos in vlc #########################################################
config.bind('z', 'hint links spawn vlc {hint-url}')
config.bind('Z', 'spawn vlc {url}')
config.bind(',z5', 'hint links spawn vlc --preferred-resolution 720 {hint-url}')
config.bind(',Z5', 'spawn vlc --preferred-resolution 720 {url}')
config.bind(',z4', 'hint links spawn vlc --preferred-resolution 480 {hint-url}') # vlc-bug: some yt videos can
config.bind(',Z4', 'spawn vlc --preferred-resolution 480 {url}')                 # only be viewed in 480p
config.bind(',z3', 'hint links spawn vlc --preferred-resolution 360 {hint-url}')
config.bind(',Z3', 'spawn vlc --preferred-resolution 360 {url}')
config.bind(',z2', 'hint links spawn vlc --preferred-resolution 240 {hint-url}')
config.bind(',Z2', 'spawn vlc --preferred-resolution 240 {url}')

###############################################################################
#                                    THEME                                    #
###############################################################################

import dracula.draw

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 4,
        'horizontal': 6
    }
})

###############################################################################
#                                     MISC                                    #
###############################################################################

# quitting ####################################################################
c.confirm_quit = ['downloads', 'multiple-tabs'] # display a confirmation window if downloads are running

c.url.start_pages = "~/.config/qutebrowser/startpage/index.html"
c.content.autoplay = False

# search engines
c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}',
                       'wiki': 'https://en.wikipedia.org/wiki/{}',
                       'yt': 'https://www.youtube.com/results?search_query={}',
                       'tra': 'https://deepl.com/translator#en/de/{}'}

# custom content blocking lists
# run :adblock-update after changing this list
c.content.blocking.adblock.lists = ["https://easylist.to/easylist/easylist.txt",
                                    "https://easylist.to/easylist/easyprivacy.txt",
                                    "https://easylist.to/easylist/fanboy-social.txt",
                                    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
                                    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
                                    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"]
