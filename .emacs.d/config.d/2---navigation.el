;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



(use-package which-key
  :demand t
  :config (which-key-mode))



; misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def '(normal visual) 'override :prefix "SPC"
  "ESC" 'keyboard-escape-quit
  "q"   'save-buffers-kill-terminal
  "Q"   'save-buffers-kill-emacs)

; help
(general-def '(normal visual) 'override :prefix "SPC h"
  "p" 'describe-package
  "f" 'describe-function
  "v" 'describe-variable
  "k" 'describe-key)
