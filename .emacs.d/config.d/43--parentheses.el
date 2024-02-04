;;; -*- lexical-binding: t; -*-



(show-paren-mode)



(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



(use-package electric
  :demand t
  :config
  (setq-default electric-indent-inhibit t)

  (electric-pair-mode)

  (add-to-list 'electric-pair-pairs '(8218 . 8216))  ;; ‚‘
  (add-to-list 'electric-pair-pairs '(8222 . 8220))) ;; „“



(use-package skparens
  :demand t
  :config
  (general-def meow-normal-state-keymap
    "%" 'skparens-change
    "D" 'skparens-delete
    "S" 'skparens-insert
    "A" 'skparens-mark-outer
    "I" 'skparens-mark-inner))
