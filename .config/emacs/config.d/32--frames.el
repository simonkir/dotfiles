;;; -*- lexical-binding: t; -*-

; * sk:keybinds
(general-def
  "C-SPC" 'other-window)

(general-def-leader
  "w c" 'delete-window
  "w o" 'delete-other-windows
  "w q" 'quit-window
  "w s" 'split-window-below
  "w v" 'split-window-right
  "w w" 'make-frame
  "w W" 'other-frame-prefix)

