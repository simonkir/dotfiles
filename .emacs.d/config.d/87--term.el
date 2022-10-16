;;; -*- lexical-binding: t; -*-



;; vterm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vterm
  :general (general-def-leader
    "SPC v" 'vterm
    "SPC V" 'vterm-other-window)

  :config
  (setq vterm-shell "/usr/bin/fish")
  (setq vterm-max-scrollback 10000)
  (setq vterm-buffer-name-string "vterm: %s"))
