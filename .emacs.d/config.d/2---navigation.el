;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



; help ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def-leader
 "h"   'describe-symbol
 "H p" 'describe-package
 "H f" 'describe-function
 "H v" 'describe-variable
 "H k" 'describe-key)

(general-def help-mode-map
  "h" 'meow-left
  "l" 'meow-right
  "n" 'help-go-forward
  "p" 'help-go-back)
