# * imports
import os, subprocess
from libqtile.config import EzKey, EzDrag, Group, Match, Screen
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

# * general settings
home = os.path.expanduser("~")

cursor_warp = False
auto_fullscreen = True
auto_minimize = False
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
    EzKey("M-<space>", lazy.next_layout()),

# ** windows
# *** status
    EzKey("M-S-q", lazy.window.kill()),
    EzKey("M-v", lazy.window.toggle_floating()),
    EzKey("M-c", lazy.window.toggle_fullscreen()),

# *** focus
    EzKey("A-<Tab>", lazy.group.next_window()),
    EzKey("A-S-<Tab>", lazy.group.prev_window()),

    EzKey("M-<Tab>", lazy.next_screen()),
    EzKey("M-S-<Tab>", lazy.prev_screen()),

    EzKey("M-k", lazy.layout.up()),
    EzKey("M-j", lazy.layout.down()),
    EzKey("M-h", lazy.layout.left()),
    EzKey("M-l", lazy.layout.right()),

    EzKey("M-a", lazy.switch_window(1)),
    EzKey("M-s", lazy.switch_window(2)),
    EzKey("M-d", lazy.switch_window(3)),
    EzKey("M-f", lazy.switch_window(4)),
    EzKey("M-g", lazy.switch_window(5)),

# *** swapping
    EzKey("M-S-h", lazy.layout.move_left()),
    EzKey("M-S-j", lazy.layout.move_down()),
    EzKey("M-S-k", lazy.layout.move_up()),
    EzKey("M-S-l", lazy.layout.move_right()),

    EzKey("M-C-h", lazy.layout.integrate_left()),
    EzKey("M-C-j", lazy.layout.integrate_down()),
    EzKey("M-C-k", lazy.layout.integrate_up()),
    EzKey("M-C-l", lazy.layout.integrate_right()),

    EzKey("M-b", lazy.layout.mode_vertical()),
    EzKey("M-S-b", lazy.layout.mode_vertical_split()),
    EzKey("M-r", lazy.layout.mode_horizontal()),
    EzKey("M-S-r", lazy.layout.mode_horizontal_split()),

# *** resizing
    EzKey("M-z", lazy.layout.grow_width(-30)),
    EzKey("M-u", lazy.layout.grow_height(-30)),
    EzKey("M-i", lazy.layout.grow_height(30)),
    EzKey("M-o", lazy.layout.grow_width(30)),

    EzKey("M-n", lazy.layout.reset_size()),

# ** restarting
    EzKey("M-S-r", lazy.reload_config()),
    EzKey("M-C-r", lazy.restart()),
]

# ** mouse
mouse = [
    EzDrag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    EzDrag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size())
]

# * groups
groups = []
group_names = [i for i in "12345678"]

group_layouts = {i: "max" for i in group_names}
group_layouts["2"] = "plasma"
group_layouts["3"] = "plasma"

# group name : wm_class (first or second field)
group_rules = {i: [] for i in group_names}
group_rules["1"] = ["firefox", "brave-browser"]
group_rules["2"] = ["emacs", "emacs-30-1"]
group_rules["3"] = ["Alacritty"]
group_rules["4"] = ["krita", "Inkscape", "libreoffice"]
group_rules["5"] = ["spotify"]

for grname in group_names:
    groups.append(Group(name=grname,
                        layout=group_layouts[grname],
                        matches=[Match(wm_class=i) for i in group_rules[grname]]))
    keys.extend([
        EzKey(f"M-{grname}", lazy.group[grname].toscreen()),
        EzKey(f"M-S-{grname}", lazy.window.togroup(grname)),
        EzKey(f"M-C-{grname}", lazy.window.togroup(grname), lazy.group[grname].toscreen()),
    ])

# * layouts
# ** defaults
layout_theme_border = {
    "border_width": 1,
    "border_focus": colors["blue"],
    "border_focus_fixed": colors["green"],
    "border_normal": colors["background"],
    "border_normal_fixed": colors["background"],
    "border_on_single": False,
    "fullscreen_border_width": 0,
}

layout_theme_no_border = {
    "border_width": 0,
    "fullscreen_border_width": 0,
}

# ** initialization
layouts = [
    layout.Plasma(**layout_theme_border),
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
    "margin": 5,
    "foreground": colors["foreground"],
    "background": colors["background"],
}

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
        widget.Plasma(
            horizontal = "R",
            vertical = "B",
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
        ),
        widget.Spacer(
            length = 5,
        ),
    ]

# * screen layout
widget_list_full = init_widget_list()
widget_list_wo_tray = init_widget_list()
widget_list_wo_tray.pop(-2)
widget_list_wo_tray.pop(-2)

# note: dirty code, be careful when changing widget order
screens = [Screen(bottom=bar.Bar(widgets=widget_list_full, size=26, opacity=0.9)),
           Screen(bottom=bar.Bar(widgets=widget_list_wo_tray, size=26, opacity=0.9))]

# * autostart
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/scripts/autostart-once.sh"])

@hook.subscribe.startup
def start_always():
    subprocess.call([home + "/.config/qtile/scripts/autostart-always.sh"])
