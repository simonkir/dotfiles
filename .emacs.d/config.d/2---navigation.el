;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



(use-package which-key
  :demand t
  :config (which-key-mode))



; help ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(bind-keys :map meow-normal-state-keymap
;;  ("SPC h p" . describe-package)
;;  ("SPC h f" . describe-function)
;;  ("SPC h v" . describe-variable)
;;  ("SPC h k" . describe-key))

(general-def-leader
 "SPC h p" 'describe-package
 "SPC h f" 'describe-function
 "SPC h v" 'describe-variable
 "SPC h k" 'describe-key)
