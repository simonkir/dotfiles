;;; -*- lexical-binding: t; -*-

; * sk:keybinds
(general-def
  "C-SPC" 'other-window)

(general-def-leader
  "w c" 'delete-window
  "w q" 'quit-window
  "w v" 'split-window-right
  "w s" 'split-window-below
  "w w" 'make-frame
  "w W" 'other-frame-prefix)

