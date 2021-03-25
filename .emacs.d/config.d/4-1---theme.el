;;; -*- lexical-binding: t; -*-



(use-package doom-themes
  :demand t
  :ensure t
  :config
  (global-hl-line-mode)
  (doom-themes-org-config)) ;; Corrects (and improves) org-mode's native fontification.
