;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



(use-package which-key
  :demand t
  :config (which-key-mode))



; help ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def '(normal visual) 'override
  "SPC h p" 'describe-package
  "SPC h f" 'describe-function
  "SPC h v" 'describe-variable
  "SPC h k" 'describe-key)
