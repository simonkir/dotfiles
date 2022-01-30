;;; -*- lexical-binding: t; -*-



; snippets ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :ensure t
  :demand t
  :config (yas-global-mode))



; templates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package autoinsert
  :demand t
  :config
  (setq auto-insert t)
  (setq auto-insert-directory "~/.emacs.d/templates/")
  (define-auto-insert 'org-mode "org-mode.org")
  (auto-insert-mode t))
