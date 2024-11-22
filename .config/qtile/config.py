# * imports
import os, subprocess
from libqtile.config import Key, Drag, Group, Match, Screen
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

# ** layouts
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod], "s", lazy.window.toggle_floating()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "space", lazy.next_layout()),

# ** windows
# *** focus
    Key(["mod1"], "Tab", lazy.group.next_window()),
    Key(["mod1", "shift"], "Tab", lazy.group.prev_window()),

    Key([mod], "Tab", lazy.next_screen()),
    Key([mod, "shift" ], "Tab", lazy.prev_screen()),

    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

# *** swapping
    Key([mod, "shift"], "f", lazy.layout.flip()),

    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

# *** resizing
    Key([mod], "n", lazy.layout.normalize()),

    Key([mod, "control"], "l",
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
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

# ** restarting
    Key([mod], "r", lazy.reload_config()),
    Key([mod, "shift"], "r", lazy.restart()),
]

# ** mouse
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

# * groups
groups = []
group_names = [i for i in "12345678"]
group_layouts = {i: "max" for i in group_names}

# group name : wm_class (first or second field)
group_rules = {i: [] for i in group_names}
group_rules["1"] = ["firefox", "brave-browser", "spotify"]
group_rules["2"] = ["emacs", "emacs-29-4"]
group_rules["3"] = ["Alacritty"]
group_rules["4"] = ["krita", "Inkscape", "libreoffice"]

for grname in group_names:
    groups.append(Group(name=grname,
                        layout=group_layouts[grname],
                        matches=[Match(wm_class=i) for i in group_rules[grname]]))
    keys.extend([
        Key([mod], grname, lazy.group[grname].toscreen()),
        Key([mod, "shift"], grname, lazy.window.togroup(grname)),
        Key([mod, "control"], grname, lazy.window.togroup(grname), lazy.group[grname].toscreen()),
    ])


# * layouts
# ** initialization
layout_theme_border = {
    "border_width"  : 1,
    "border_focus"  : colors["blue"],
    "border_normal" : colors["background"]
}

layout_theme_no_border = {
    "border_width": 0,
    "fullscreen_border_width": 0
}

layouts = [
    layout.RatioTile(**layout_theme_border),
    layout.MonadTall(**layout_theme_border),
    layout.MonadWide(**layout_theme_border),
    layout.Max(**layout_theme_no_border),
]

# ** floating layout
floating_types = ["notification", "toolbar", "splash", "dialog"]
floating_layout = layout.Floating(**layout_theme_no_border)

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

# *** groups
        widget.GroupBox(
            margin_y = 4, margin_x = 0,
            padding_y = 0, padding_x = 1,
            borderwidth = 2,

            disable_drag = True,
            highlight_method = "line",

            font = widget_defaults["font"] + " Bold",
            fontsize = 16,

            active = colors["blue"],
            inactive = colors["foreground"],
            highlight_color = colors["background"],
            this_current_screen_border = colors["blue"], # current screen, focused group
            this_screen_border = colors["magenta"], # other screens, focused groups
            other_screen_border = colors["background"], # current screen, focused groups on other screens
            other_current_screen_border = colors["background"], # other screens, focused groups on other screens
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
            filename = "~/.config/qtile/icons/bluetooth.svg",
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

# *** volume
        widget.Image(
            filename = "~/.config/qtile/icons/volume.svg",
            margin = icon_margin,
        ),
        widget.Volume(
            mute_format = "–",
            emoji = False,
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
