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
colors = {
    "black"      : "#292d3e",
    "red"        : "#ff5370",
    "green"      : "#c3e88d",
    "yellow"     : "#ffcb6b",
    "blue"       : "#82aaff",
    "magenta"    : "#c792ea",
    "cyan"       : "#89ddff",
    "white"      : "#eeffff",
    "foreground" : "#eeffff",
    "background" : "#292d3e"
}

# * keybinds
keys = [

# ** restarting
    Key([mod], "r", lazy.reload_config()),
    Key([mod, "shift"], "r", lazy.restart()),

# ** windows
# *** layouts
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

# *** focus
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

# *** resizing
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

# ** screens
    Key([mod], "Tab", lazy.next_screen()),
    Key([mod, "shift" ], "Tab", lazy.prev_screen()),

# ** layout-specific
# *** monadtall / -wide layout
    Key([mod, "shift"], "f", lazy.layout.flip()),

    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

# *** foating layout
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod], "s", lazy.window.toggle_floating()),

# *** bsp layout
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

for grname, grlayout, grlabel in zip(group_names, group_layouts, group_labels):
    groups.append(Group(name=grname, layout=grlayout, label=grlabel))

# ** keybinds
for grname in group_names:
    keys.extend([
        Key([mod], grname, lazy.group[grname].toscreen()),
        Key([mod, "shift"],   grname, lazy.window.togroup(grname)),
        Key([mod, "control"], grname, lazy.window.togroup(grname), lazy.group[grname].toscreen()),
    ])

# ** window rules
@hook.subscribe.client_new
def assign_app_group(client):
    # get first field of WM_CLASS
    wm_class = client.window.get_wm_class()[0]

    d = {
        group_names[0]: ["navigator", "firefox", "brave-browser"],
        group_names[1]: ["emacs", "Emacs-29-4", "alacritty"],
        group_names[2]: ["krita", "org.inkscape.inkscape", "libreoffice"],
        group_names[3]: ["chromium", "google-chrome"]
    }

    for key, val in d.items():
        if wm_class.lower() in [i.lower() for i in val]:
            client.togroup(key)

# * layouts
# ** initialization
layout_theme = {
    "margin"        :  0,
    "border_width"  :  0,
    "border_focus"  :  "#5e81ac",
    "border_normal" : "#4c566a"
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
    "foreground": colors["foreground"],
    "background": colors["background"],
}

icon_margin = 5
sep_linewidth = 1
sep_padding = 10

# ** widgets
# function needed, bc deepcopying the list is hard
def init_widget_list():
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
            this_current_screen_border = colors["blue"],
            active = colors["magenta"],
            inactive = colors["foreground"],
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
            active_color = colors["foreground"],
        ),
        widget.WindowName(
        ),

# *** temperature
        widget.Image(
            filename = "~/.config/qtile/icons/temperature.svg",
            margin = icon_margin,
        ),
        widget.Image(
            filename = "~/.config/qtile/icons/temperature.png",
            margin = icon_margin,
        ),
        widget.ThermalSensor(
            format = "{temp}{unit}",
            threshold = 70,
            foreground = colors["foreground"],
            foreground_alert = colors["red"],
            update_interval = 2,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** cpu
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

# *** memory
        widget.Image(
            filename = "~/.config/qtile/icons/memory.png",
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
            filename = "~/.config/qtile/icons/battery.png",
            margin = icon_margin,
        ),
        widget.Battery(
            format = "{char:2s}{percent:.0%}",
            charge_char = "▲",
            discharge_char = "▼",
            not_charging_char = "▶",
            full_char = "▶",
            show_short_text = False,
            low_foreground = colors["red"],
            low_percentage = 0.2,
            update_interval = 10,
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** bluetooth
        widget.Image(
            filename = "~/.config/qtile/icons/bluetooth.png",
            margin = icon_margin,
        ),
        widget.Bluetooth(
            default_text = "{num_connected_devices}",
            adapter_format = "{name} {powered}{discovery}",
            device_format = "{name} {symbol}{battery_level}",
            device_battery_format = " {battery}%",
            symbol_powered = ("◆", "◇"),
            symbol_discovery = (" …", ""),
            symbol_paired = "◇",
            symbol_connected = "◆",
        ),
        widget.Sep(
            linewidth = sep_linewidth,
            padding = sep_padding,
        ),

# *** clock
        widget.Image(
            filename = "~/.config/qtile/icons/clock.png",
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
# note: dirty code, be careful when changing widget order
screens = [Screen(bottom=bar.Bar(widgets=init_widget_list(), size=26, opacity=0.9)),
           Screen(bottom=bar.Bar(widgets=init_widget_list()[:-2], size=26, opacity=0.9))]

# * autostart
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/scripts/autostart-once.sh'])

@hook.subscribe.startup
def start_always():
    subprocess.call([home + '/.config/qtile/scripts/autostart-always.sh'])
