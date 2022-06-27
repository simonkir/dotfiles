;;; -*- lexical-binding: t; -*-



(use-package evil
  :demand t
  :init
  (setq evil-respect-visual-line-mode t
        evil-want-integration t
        evil-want-keybinding nil)

  :config
  (evil-mode 1)
  ;;(setq evil-want-minibuffer t) ;; yields to problems with ido

  (general-def 'insert
    "C-k" 'evil-previous-line
    "C-j" 'evil-next-line
    "C-h" 'backward-char
    "C-l" 'forward-char))



(use-package evil-collection
  :after evil
  :config (evil-collection-init))
