;;; -*- lexical-binding: t; -*-



(use-package doom-modeline
  :demand t
  :ensure t

  :custom
  ;; needs to be set explicitly when running in server mode
  (doom-modeline-icon t)
  (doom-modeline-buffer-encoding nil)

  :config
  (doom-modeline-mode 't))
