hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",

        numlock_by_default = true,

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            middle_button_emulation = true,

            tap_to_click = true,
            clickfinger_behavior = true,
        },
    },
})
