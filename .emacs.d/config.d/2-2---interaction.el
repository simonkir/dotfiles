;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



(use-package which-key
  :defer 2
  :config (which-key-mode))



;;(use-package smex
;;  :after ido
;;  :ensure t
;;  :config (smex-initialize)
;;
;;  :general
;;  ("M-x" 'smex)
;;  ('normal 'override "SPC x" 'smex))
