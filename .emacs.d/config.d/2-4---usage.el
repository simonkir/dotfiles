;;; -*- lexical-binding: t; -*-



; insertion  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default tab-width 4)

(use-package popup-kill-ring
  :ensure t
  :general ('insert "M-y" 'popup-kill-ring))



; buffer handling  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-auto-revert-mode)

(general-def 'normal
  "g r" 'revert-buffer)
