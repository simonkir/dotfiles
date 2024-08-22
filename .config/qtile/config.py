# * imports
import os, subprocess
from libqtile.config import Key, Screen, Group, Drag
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

# * general settings
mod = "mod4"
mod1 = "alt"
home = os.path.expanduser('~')

cursor_warp = False
auto_fullscreen = True
bring_front_click = False
follow_mouse_focus = True
reconfigure_screens = True
focus_on_window_activation = "smart"

dgroups_key_binder = None
dgroups_app_rules = []
main = None

# * theme
colors = [
    "#292d3e", # color 0, black
    "#ff5370", # color 1, red
    "#c3e88d", # color 2, green
    "#ffcb6b", # color 3, yellow
    "#82aaff", # color 4, blue
    "#c792ea", # color 5, magenta
    "#89ddff", # color 6, cyan
    "#eeffff", # color 7, silver
    "#eeffff", # foreground
    "#292d3e"  # background
]

# * keybinds
keys = [

# ** window management
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),

# ** layout, screens, focus
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

    Key([mod], "Tab", lazy.next_screen()),
    Key([mod, "shift" ], "Tab", lazy.prev_screen()),

    Key(["mod1"], "Tab", lazy.group.next_window()),
    Key(["mod1", "shift"], "Tab", lazy.group.prev_window()),

    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

# ** resizing
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

# ** monadtall / -wide layout
    Key([mod, "shift"], "f", lazy.layout.flip()),

    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

# ** foating layout
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod], "s", lazy.window.toggle_floating()),

# ** bsp layout
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

# ** mouse
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

# * workspaces
# ** initialization
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_labels = group_names[:]
group_layouts = ["max" for i in group_names]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# ** keybinds
for i in groups:
    keys.extend([

        #CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # MOVE WINDOW TO SELECTED WORKSPACE 1-8
        Key([mod, "shift"],   i.name, lazy.window.togroup(i.name)),
        Key([mod, "control"], i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()),
    ])

# ** window rules
@hook.subscribe.client_new
def assign_app_group(client):
    # get first field of WM_CLASS
    wm_class = client.window.get_wm_class()[0]

    d = {
        group_names[0]: ["navigator", "firefox", "brave-browser", "qutebrowser"],
        group_names[1]: ["emacs", "Emacs-29-4", "alacritty"],
        group_names[2]: ["krita", "libreoffice", "org.pwmt.zathura", "blender", "org.inkscape.inkscape"],
        group_names[3]: ["chromium", "google-chrome"]
    }

    for key, val in d.items():
        if wm_class.lower() in [i.lower() for i in val]:
            client.togroup(key)

# * layouts
# ** initialization
layout_theme = {
    "margin":        0,
    "border_width":  0,
    "border_focus":  "#5e81ac",
    "border_normal": "#4c566a"
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

# ** floating layout
floating_types = ["notification", "toolbar", "splash", "dialog"]
floating_layout = layout.Floating(fullscreen_border_width = 0, border_width = 0)

# * bar
# ** settings
widget_defaults = {
    "font": "Fira Code",
    "fontsize": 12,
    "padding": 2,
    "foreground": colors[8],
    "background": colors[9],
}

# ** widgets
# function needed bc windget_list cannot be deepcopied easily
def init_widgets_list():
    icon_margin = 5
    sep_linewidth = 1
    sep_padding = 10

    return [

# *** workspaces
        widget.GroupBox(
            margin_y = 4, margin_x = 0,
            padding_y = 0, padding_x = 3,
            borderwidth = 0,

            disable_drag = True,
            highlight_method = "text",

            font = widget_defaults["font"] + " Bold",
            fontsize = 16,
            this_current_screen_border = colors[4],
            active = colors[5],
            inactive = colors[8],
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** layout
        widget.CurrentLayoutIcon(
            scale = 0.6,
        ),
        widget.CurrentLayout(
            font = widget_defaults["font"] + " Bold"
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** window-name
        widget.CurrentScreen(
            active_text = "",
            inactive_text = "",
            active_color = colors[8],
            inactive_color = colors[8],
        ),
        widget.WindowCount(
            text_format = "[{num}]",
        ),
        widget.WindowName(
        ),

# *** temperature
        widget.Image(
            filename = "~/.config/qtile/icons/temperature.svg",
            margin = icon_margin,
        ),
        widget.ThermalSensor(
            format = "{temp}{unit}",
            threshold = 70,
            foreground = colors[8],
            foreground_alert = colors[1],
            update_interval = 2,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** cpu
        widget.Image(
            filename = "~/.config/qtile/icons/cpu.svg",
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

# *** memory
        widget.Image(
            filename = "~/.config/qtile/icons/memory.svg",
            margin = icon_margin,
        ),
        widget.Memory(
            format = "{MemUsed:.1f}G",
            measure_mem = "G",
            update_interval = 2,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** battery
        widget.Image(
            filename = "~/.config/qtile/icons/battery.svg",
            margin = icon_margin,
        ),
        widget.Battery(
            format = "{char:2s}{percent:.0%}",
            charge_char = "▲",
            discharge_char = "▼",
            not_charging_char = "▶",
            full_char = "▶",
            show_short_text = False,
            low_foreground = colors[1],
            low_percentage = 0.2,
            update_interval = 10,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** clock
        widget.Image(
            filename = "~/.config/qtile/icons/clock.svg",
            margin = icon_margin,
        ),
        widget.Clock(
            format = "%H:%M",
            update_interval = 1,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** systray
        widget.Systray(
            icon_size = 20,
        )
    ]

# * screen layout
# ** primary / secondary widget list
def init_widgets(has_tray=False):
    widgets = init_widgets_list()

    # note: dirty code, but does the job
    #       be careful when changing widget order
    #       should be fixed at some point

    try:
        with open("/sys/class/power_supply/BAT0/capacity") as f:
            pass
    except FileNotFoundError:
        widgets.pop(7) # remove battery icon
        widgets.pop(7) # remove battery widget
        widgets.pop(7) # remove separator right of battery widget

    if not has_tray:
        widgets.pop(-1) # remove systray widget
        widgets.pop(-1) # remove sep widget

    return widgets

widgets_screen_primary = init_widgets(has_tray=True)
widgets_screen_secondary = init_widgets(has_tray=False)

# ** screen layout
screens = [Screen(bottom=bar.Bar(widgets=widgets_screen_primary, size=26, opacity=0.9)),
           Screen(bottom=bar.Bar(widgets=widgets_screen_secondary, size=26, opacity=0.9))]

# * autostart
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/scripts/autostart-once.sh'])

@hook.subscribe.startup
def start_always():
    subprocess.call([home + '/.config/qtile/scripts/autostart-always.sh'])
