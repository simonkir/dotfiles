-- * layout settings
hl.config({
    general = {
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "scrolling",
    },

    -- dwindle = {
    --     preserve_split = true, -- You probably want this
    --     force_split = 2,
    -- },

    -- master = {
    --     new_status = "slave",
    -- },

    scrolling = {
        wrap_focus = false,
        wrap_swapcol = false,
    },
})

hl.workspace_rule({
        workspace = "1",
        layout = "monocle",
})

-- for i = 1, 8 do
--     hl.workspace_rule({ workspace = i, persistent = true })
-- end

-- * window rules
-- ** application workspace rules
hl.window_rule({ match = { class = "firefox" }, workspace = "1" })
hl.window_rule({ match = { class = "Emacs.*" }, workspace = "2" })
hl.window_rule({ match = { class = "Alacritty" }, workspace = "3" })
hl.window_rule({ match = { class = ".*hunderbird" }, workspace = "4" })
hl.window_rule({ match = { class = "spotify" }, workspace = "5" })

-- ** application specific
hl.window_rule({ match = { class = "hyprland-run" }, move  = "20 monitor_h-120", float = true })

hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})

-- ** compatibility
hl.window_rule({
    match = { class = ".*" },

    -- Ignore maximize requests from all apps. You'll probably like this.
    suppress_event = "maximize",

    no_initial_focus = false,
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

