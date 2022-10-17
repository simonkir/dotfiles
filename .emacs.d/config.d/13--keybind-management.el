;;; -*- lexical-binding: t; -*-



;; explanation:
;;
;; general-def-leader binds into sk:leader-map
;;   → leader keybinds are the same for all major-modes
;;   → keybinds accessible by SPC key using meow keypad mode
;;
;; general-def-localleader binds into mode-specific maps under prefix "C-c l"
;;   → localleader keybinds vary depending on the major-mode
;;   → keybinds accessible using SPC SPC in meow keypad mode



(use-package general
  :demand t
  :config
  (setq sk:leader-map (make-sparse-keymap))

  (general-create-definer general-def-leader :keymaps 'sk:leader-map)
  ;;(general-create-definer general-def-localleader :prefix "C-c l")
    
  (general-def package-menu-mode-map "U" 'package-menu-mark-upgrades))



(use-package which-key
  :demand t
  :config (which-key-mode))
