;;; -*- lexical-binding: t; -*-

; * consult
(use-package consult
  :general
  (general-def-leader
    "b b" 'consult-buffer
    "b B" 'consult-project-buffer
    "w b" 'consult-buffer-other-window
    "f b" 'consult-bookmark
    "f r" 'consult-recent-file
    "v e" 'consult-flymake
    "v j" 'consult-outline)

  (general-def meow-normal-state-keymap
    "P" 'consult-yank-pop
    "M" 'consult-goto-line
    "v" 'consult-line))
