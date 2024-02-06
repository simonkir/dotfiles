;;; -*- lexical-binding: t; -*-



;; explanation:
;;
;; general-def-leader binds into sk:leader-map
;;   → leader keybinds are the same for all major-modes
;;   → keybinds accessible by SPC key using meow keypad mode



(use-package general
  :demand t
  :config
  (setq sk:leader-map (make-sparse-keymap))
  (general-create-definer general-def-leader :keymaps 'sk:leader-map)
  (general-def package-menu-mode-map "U" 'package-menu-mark-upgrades))
