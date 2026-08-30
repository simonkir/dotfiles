hl.on("hyprland.start", function ()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user start ssh-agent.service")

  hl.exec_cmd("noctalia")
  -- hl.exec_cmd("~/.config/conky/launch-conky.sh")

  hl.exec_cmd("emacs --daemon")

  hl.exec_cmd("wl-past --type text --watch cliphist store")
  hl.exec_cmd("wl-past --type image --watch cliphist store")
end)
