;;; -*- lexical-binding: t; -*-



(show-paren-mode)



(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



(use-package electric
  :demand t
  :config
  (electric-pair-mode)

  (add-to-list 'electric-pair-pairs '(8218 . 8216))  ;; ‚‘
  (add-to-list 'electric-pair-pairs '(8222 . 8220))) ;; „“



(use-package skparens
  :demand t
  :config
  (general-def meow-normal-state-keymap
    "%" 'skparens-change
    "D" 'skparens-delete
    "S" 'skparens-surround-region))
