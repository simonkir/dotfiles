;;; -*- lexical-binding: t; -*-

; * frames-only-mode
(use-package frames-only-mode
  :demand t
  :config
  ;; docs: see frames-only-mode src
  (setq frames-only-mode-configuration-variables
        '((pop-up-frames graphic-only)
          (mouse-autoselect-window nil)
          (focus-follows-mouse nil)
          (frame-auto-hide-function delete-frame)))

  (frames-only-mode))

; * sk:keybinds
(general-def-leader
  "w w" 'make-frame
  "w W" 'other-frame-prefix)

