;;; -*- lexical-binding: t; -*-



(use-package doom-themes
  :demand t
  :config
  (global-hl-line-mode)
  (doom-themes-org-config)
  (load-theme 'doom-one t)) ;; Corrects (and improves) org-mode's native fontification.
