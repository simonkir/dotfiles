;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



; help ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def-leader
 "h" 'describe-symbol
 "H" 'describe-key)

(general-def help-mode-map
  "<escape>" 'meow-cancel-selection
  "h" 'meow-left
  "l" 'meow-right
  "e" 'meow-next-word
  "E" 'meow-next-symbol
  "b" 'meow-back-word
  "B" 'meow-back-symbol
  "n" 'help-go-forward
  "p" 'help-go-back)
