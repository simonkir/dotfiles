;;; -*- lexical-binding: t; -*-



(use-package general
  :demand t
  :config
  (general-def package-menu-mode-map "U" 'package-menu-mark-upgrades)
  
  (general-create-definer general-def-leader
    :keymaps '(meow-normal-state-keymap meow-motion-state-keymap)))
