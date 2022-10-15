;;; -*- lexical-binding: t; -*-



; spacing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(blink-cursor-mode -1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(bind-keys ("M-SPC" . delete-horizontal-space))



; visual undo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(use-package vundo
;;  :general ('normal "U" 'vundo)
;;  :config
;;  (setq vundo-glyph-alist vundo-unicode-symbols)
;;  (general-def 'normal vundo-mode-map
;;    "j" 'vundo-next
;;    "k" 'vundo-previous))
