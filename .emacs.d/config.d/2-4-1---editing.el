;;; -*- lexical-binding: t; -*-



(use-package evil-lion
  :ensure t
  :after evil
  :general ('(normal visual) 'override :prefix "g"
            "l" 'evil-lion-left
            "L" 'evil-lion-right))



(use-package evil-surround
  :ensure t
  :after evil
  :defer 1
  :config (global-evil-surround-mode 1))
