import os
import re
import socket
import subprocess
from libqtile.config import Drag, Key, Screen, Group, Drag, Click, Rule
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer
#import arcobattery



###############################################################################
#                                     VARS                                    #
###############################################################################

mod = "mod4"
mod1 = "alt"
home = os.path.expanduser('~')

# colors ######################################################################
def init_colors():
    return [["#282c34", "#282c34"], # color 0, black
            ["#ed254e", "#ed254e"], # color 1, red
            ["#71f79f", "#71f79f"], # color 2, green
            ["#f9dc5c", "#f9dc5c"], # color 3, yellow
            ["#66abff", "#66abff"], # color 4, blue
            ["#c74ded", "#c74ded"], # color 5, magenta
            ["#00c1e4", "#00c1e4"], # color 6, teal
            ["#dcdfe4", "#dcdfe4"], # color 7, silver
            ["#c3c7d1", "#c3c7d1"], # foreground
            ["#141925", "#141925"]] # background


colors = init_colors()



###############################################################################
#                                   KEYBINDS                                  #
###############################################################################

# keybinds ####################################################################

keys = [

    # SUPER + FUNCTION KEYS
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),


    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

    # CHANGE SCREENS
    Key([mod], "Tab", lazy.next_screen()),
    Key([mod, "shift" ], "Tab", lazy.prev_screen()),

    # CYCLE WINDOWS
    Key(["mod1"], "Tab",          lazy.group.next_window()),
    Key(["mod1", "shift"], "Tab", lazy.group.prev_window()),

    # CHANGE FOCUS
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),

    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod], "s", lazy.window.toggle_floating()),

###     # FLIP LAYOUT FOR BSP
###     Key([mod, "mod1"], "k", lazy.layout.flip_up()),
###     Key([mod, "mod1"], "j", lazy.layout.flip_down()),
###     Key([mod, "mod1"], "l", lazy.layout.flip_right()),
###     Key([mod, "mod1"], "h", lazy.layout.flip_left()),
### 
###     # MOVE WINDOWS UP OR DOWN BSP LAYOUT
###     Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
###     Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
###     Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
###     Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

    ]

# mouse configuration #########################################################
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]



###############################################################################
#                                    GROUPS                                   #
###############################################################################

# workspace initialization ####################################################
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_labels = group_names
group_layouts = ["max", "monadtall", "max", "max", "monadtall", "monadtall", "max", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# workspace keybinds ##########################################################
for i in groups:
    keys.extend([

        #CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # MOVE WINDOW TO SELECTED WORKSPACE 1-8
        Key([mod, "shift"],   i.name, lazy.window.togroup(i.name)),
        Key([mod, "control"], i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()),
    ])

# assign applications to workspaces ###########################################
@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    ### Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient ###
    d[group_names[0]] = ["Navigator", "Firefox", "Chromium", "navigator", "firefox", "chromium", "qutebrowser"]
    d[group_names[1]] = ["urxvt", "termite", "emacs"]
    d[group_names[2]] = ["krita", "libreoffice", "org.pwmt.zathura", "Blender"]

    wm_class = client.window.get_wm_class()[0]

    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen(toggle=False)


   
###############################################################################
#                                   LAYOUTS                                   #
###############################################################################

def init_layout_theme():
    return {"margin":        0,
            "border_width":  1,
            "border_focus":  "#5e81ac",
            "border_normal": "#4c566a"
            }

layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]



###############################################################################
#                                     BAR                                     #
###############################################################################

# default settings ############################################################
def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                foreground = colors[8],
                background = colors[9],
                )

widget_defaults = init_widgets_defaults()

icon_margin = 5
sep_linewidth = 1
sep_padding = 10

# widget list #################################################################
def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [

        # workspaces ##########################################################
        widget.GroupBox(
            margin_y = 3, margin_x = 0,
            padding_y = 6, padding_x = 5,
            borderwidth = 0,
            disable_drag = True,
            highlight_method = "text",
            fontsize = 16,
            this_current_screen_border = colors[4],
            active = colors[5],
            inactive = colors[8],
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # layout section ######################################################
        widget.CurrentLayoutIcon(
            scale = 0.7,
        ),
        widget.CurrentLayout(
            font = "Noto Sans Bold",
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # window name section #################################################
        widget.CurrentScreen(
            font = "FontAwesome",
            active_text = "",
            inactive_text = "",
            active_color = colors[8],
            inactive_color = colors[8],
        ),
        widget.WindowName(
        ),

        # updates #############################################################
        # widget.TextBox(
        #     font = "FontAwesome",
        #     fontsize = 16,
        #     text = "  ",
        #     padding = 0,
        #     foreground = colors[5],
        # ),
        widget.Image(
            filename = "~/.config/qtile/icons/updates.png",
            margin = icon_margin,
        ),
        widget.CheckUpdates(
            custom_command = "checkupdates",
            display_format = "{updates}",
            no_update_string = "0",
            update_interval = 1800,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # battery #############################################################
        # widget.TextBox(
        #     font = "FontAwesome",
        #     fontsize = 16,
        #     text = "  ",
        #     padding = 0,
        #     foreground = colors[4],
        # ),
        widget.Image(
            filename = "~/.config/qtile/icons/battery.png",
            margin = icon_margin,
        ),
        widget.Battery(
            #hide_threshold = 0.9, # doesnt hide icon
            low_percentage = 0.2,
            notify_below = 0.25,
            charge_char = "∧",
            discharge_char = "∨",
            full_string = "full",
            update_interval = 10,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # cpu #################################################################
        # widget.TextBox(
        #     font = "FontAwesome",
        #     fontsize = 16,
        #     text = "  ",
        #     padding = 0,
        #     foreground = colors[5],
        # ),
        widget.Image(
            filename = "~/.config/qtile/icons/cpu.png",
            margin = icon_margin,
        ),
        widget.CPU(
            format = "{load_percent}%",
            update_interval = 2,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # temperature #########################################################
        # widget.TextBox(
        #     font = "FontAwesome",
        #     fontsize = 16,
        #     text = "  ",
        #     padding = 0,
        #     foreground = colors[5],
        # ),
        widget.Image(
            filename = "~/.config/qtile/icons/temperature.png",
            margin = icon_margin,
        ),
        widget.ThermalSensor(
            threshold = 70,
            foreground = colors[8],
            foreground_alert = colors[1],
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # memory ##############################################################
        # widget.TextBox(
        #     font = "FontAwesome",
        #     fontsize = 16,
        #     text = "  ",
        #     padding = 0,
        #     foreground = colors[4],
        # ),
        widget.Image(
            filename = "~/.config/qtile/icons/memory.png",
            margin = icon_margin,
        ),
        widget.Memory(
            format = "{MemUsed:.1f}G",
            measure_mem = "G",
            update_interval = 1,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # clock ###############################################################
        # widget.TextBox(
        #     font = "FontAwesome",
        #     fontsize = 16,
        #     text = "  ",
        #     padding = 0,
        #     foreground = colors[4],
        # ),
        widget.Image(
            filename = "~/.config/qtile/icons/clock.png",
            margin = icon_margin,
        ),
        widget.Clock(
            format = "%H:%M",
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

        # systray #############################################################
        widget.Systray(
            icon_size = 20,
        ),
    ]
    return widgets_list

widgets_list = init_widgets_list()

def init_widgets(has_tray=False):
    widgets = init_widgets_list()

    if not has_tray:
        # delete tray
        # because the tray is *always* the last element, no complicated code
        # such as the one below for checkupdates widget is required
        del widgets[-2:-1]

        # bug: on dual monitor setup, the non-tray widget would always display 0
        # therefore: remove checkupdates widget on non-tray screens
        checkupdates_instance = None
        # get checkupdates widget (to gather its index in the next step)
        for x in widgets:
            # somehow, an AttributeError is raised when no CheckUpdates widget
            # is in the widgets list
            try:
                isinst = isinstance(x, widget.check_updates.CheckUpdates)
            except AttributeError:
                pass
            else:
                if isinst:
                    checkupdates_instance = x

        # get checkupdates widget index, if the widget is present
        try:
            update_index = widgets.index(checkupdates_instance)
        # no checkupdates widget found
        except ValueError:
            pass
        # no exception raised, thus deleting the widget
        # note: this only works if the widget isn't the outermost one
        else:
            del widgets[update_index-1:update_index+2]

    return widgets

widgets_screen1 = init_widgets(True)  # tray
widgets_screen2 = init_widgets(False) # no tray

def init_screens():
    return [Screen(bottom=bar.Bar(widgets=widgets_screen1, size=26, opacity=0.65)),
            Screen(bottom=bar.Bar(widgets=widgets_screen2, size=26, opacity=0.65))]
screens = init_screens()



###############################################################################
#                                  AUTOSTART                                  #
###############################################################################

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart-once.sh'])

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    #subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart-always.sh'])



###############################################################################
#                                     MISC                                    #
###############################################################################

# settings ####################################################################
auto_fullscreen            = True
bring_front_click          = False
cursor_warp                = True
follow_mouse_focus         = True
focus_on_window_activation = "smart"

dgroups_key_binder = None
dgroups_app_rules = []
main = None

# floating ####################################################################
# @hook.subscribe.client_new
# def set_floating(window):
#     if (window.window.get_wm_transient_for()
#             or window.window.get_wm_type() in floating_types):
#         window.floating = True
# 
# floating_types = ["notification", "toolbar", "splash", "dialog"]
# floating_layout = layout.Floating(float_rules=[
#     {'wmclass': 'Arcolinux-welcome-app.py'},
#     {'wmclass': 'Arcolinux-tweak-tool.py'},
#     {'wmclass': 'Arcolinux-calamares-tool.py'},
#     {'wmclass': 'confirm'},
#     {'wmclass': 'dialog'},
#     {'wmclass': 'download'},
#     {'wmclass': 'error'},
#     {'wmclass': 'file_progress'},
#     {'wmclass': 'notification'},
#     {'wmclass': 'splash'},
#     {'wmclass': 'toolbar'},
#     {'wmclass': 'confirmreset'},
#     {'wmclass': 'makebranch'},
#     {'wmclass': 'maketag'},
#     {'wmclass': 'Arandr'},
#     {'wmclass': 'feh'},
#     {'wmclass': 'Galculator'},
#     {'wmclass': 'arcolinux-logout'},
#     {'wmclass': 'xfce4-terminal'},
#     {'wname': 'branchdialog'},
#     {'wname': 'Open File'},
#     {'wname': 'pinentry'},
#     {'wmclass': 'ssh-askpass'},
# 
# ],  fullscreen_border_width = 0, border_width = 0)
