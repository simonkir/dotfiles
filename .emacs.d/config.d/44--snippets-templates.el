;;; -*- lexical-binding: t; -*-



; snippets ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :demand t
  :config
  (general-def yas-minor-mode-map
    "<tab>" nil
    "TAB" nil)
  
  (yas-global-mode))



; templates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package autoinsert
  :demand t
  :config
  (setq auto-insert nil)
  (setq auto-insert-directory "~/.emacs.d/templates/")
  (define-auto-insert 'org-mode "org-mode.org")
  (define-auto-insert 'glsl-mode "glsl-mode.frag"))
