;;; -*- lexical-binding: t; -*-

; * embark
(use-package embark
  :general (general-def
    "C-." 'embark-act
    "C-s" 'embark-isearch-forward)

  :config
  (setq embark-mixed-indicator-delay 0)

  (general-def 'embark-become-file+buffer-map
    "r" 'consult-recent-file
    "B" 'consult-bookmark
    "b" 'consult-buffer
    "p" 'consult-project-buffer)

  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
  (vertico-multiform-mode))

(use-package embark-consult
  :demand t
  :after embark)

; * prompts
(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)
