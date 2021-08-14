;;; -*- lexical-binding: t; -*-



;; note: requires running ‚all-the-icons-install-fonts‘
;; for the icons to appear correctly
(use-package doom-modeline
  :demand t
  :ensure t

  :custom
  ;; needs to be set explicitly when running in server mode
  (doom-modeline-icon t)
  (doom-modeline-buffer-encoding nil)

  :config
  (doom-modeline-mode 't))
