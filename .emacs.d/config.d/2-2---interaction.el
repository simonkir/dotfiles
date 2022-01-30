;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)



(use-package which-key
  :defer 4
  :ensure t
  :config
  (which-key-mode))



(use-package smex
  :after ido
  :ensure t
  :config
  (smex-initialize)

  :general
  ("M-x" 'smex)
  ('normal 'override "SPC x" 'smex))
