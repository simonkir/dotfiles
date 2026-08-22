hl.on("hyprland.start", function ()
  -- hl.exec_cmd("dunst")
  hl.exec_cmd("nm-applet")

  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  -- hl.exec_cmd("~/.config/conky/launch-conky.sh")

  hl.exec_cmd("emacs --daemon")

  hl.exec_cmd("wl-past --type text --watch cliphist store")
  hl.exec_cmd("wl-past --type image --watch cliphist store")
end)
