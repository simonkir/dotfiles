;;; -*- lexical-binding: t; -*-



; spacing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(general-def '(normal visual insert) 'override
  "M-SPC" 'delete-horizontal-space)



; visual undo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vundo
  :general ('normal "U" 'vundo)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols)
  (general-def 'normal vundo-mode-map
    "j" 'vundo-next
    "k" 'vundo-previous))
