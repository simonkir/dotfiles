-- * general keybinds
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("xkill"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- * workspace keybinds
for i = 1, 8 do
    hl.bind("SUPER + " .. i,             hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind("SUPER + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i, follow = false }))
    hl.bind("SUPER + CTRL + " .. i,      function()
                hl.dispatch(hl.dsp.window.move({ workspace = i, follow = false }))
                hl.dispatch(hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    end)
end

hl.bind("ALT + TAB", hl.dsp.window.cycle_next({ tiled = true }))

hl.bind("SUPER + TAB",  hl.dsp.focus({ monitor = "+1" }))
hl.bind("SUPER + SHIFT + TAB",  hl.dsp.workspace.swap_monitors({ monitor1 = "eDP-1", monitor2 = "HDMI-A-1"}))
hl.bind("SUPER + CTRL + TAB", function()
        hl.dispatch(hl.dsp.workspace.swap_monitors({ monitor1 = "eDP-1", monitor2 = "HDMI-A-1"}))
        hl.dispatch(hl.dsp.focus({ monitor = "+1" }))
end)

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Example special workspace (scratchpad)
-- hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- * layout keybinds
hl.bind("SUPER + SPACE", function ()
    -- local layouts     = { "dwindle", "master", "scrolling", "monocle" }
    local layouts     = { "dwindle", "scrolling", "monocle" }
    local workspace   = hl.get_active_workspace()
    if hl.get_active_special_workspace() then
        workspace = hl.get_active_special_workspace()
    end

    local next_layout = layouts[1]

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

    if workspace.special then
        hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
    else
        hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
    end
end)

hl.bind("SUPER + F", hl.dsp.layout("togglesplit"))    -- dwindle only

-- * window keybinds
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
