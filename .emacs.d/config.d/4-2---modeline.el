;;; -*- lexical-binding: t; -*-



;; note: requires running ‚all-the-icons-install-fonts‘
;; for the icons to appear correctly
(use-package doom-modeline
  :ensure t
  :demand t
  :config
  ;; needs to be set explicitly when running in server mode
  (setq doom-modeline-icon t)
  (setq doom-modeline-buffer-encoding nil)
  (doom-modeline-mode 't))
