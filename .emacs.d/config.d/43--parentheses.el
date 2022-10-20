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
    "S" 'skparens-surround-region-with))



;;(use-package evil-surround
;;  :after evil
;;  :demand t
;;  :config
;;  (setq-default evil-surround-pairs-alist (cons '(?„ . ("„" . "“")) evil-surround-pairs-alist))
;;  (setq-default evil-surround-pairs-alist (cons '(?\“ . ("“" . "”")) evil-surround-pairs-alist))
;;  (setq-default evil-surround-pairs-alist (cons '(?‚ . ("‚" . "‘")) evil-surround-pairs-alist))
;;  (setq-default evil-surround-pairs-alist (cons '(?‘ . ("‘" . "’")) evil-surround-pairs-alist))
;;
;;  (global-evil-surround-mode 1))



;;(use-package evil-lion
;;  :after evil
;;  :general ('(normal visual) 'override
;;    "g l" 'evil-lion-left
;;    "g L" 'evil-lion-right))
