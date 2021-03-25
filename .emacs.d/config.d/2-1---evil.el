;;; -*- lexical-binding: t; -*-



(use-package evil
  :demand t
  :ensure t
  :init
  (setq evil-respect-visual-line-mode t
        evil-want-integration t
        evil-want-keybinding nil)


  :config
  (evil-mode 1)

  (general-def 'insert
    "C-k" 'evil-previous-line
    "C-j" 'evil-next-line
    "C-h" 'backward-char
    "C-l" 'forward-char))



(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
