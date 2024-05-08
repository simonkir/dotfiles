;;; -*- lexical-binding: t; -*-

; * eglot
(use-package eglot
  :hook (python-mode . eglot-ensure)
  :config
  (setq eglot-autoshutdown t)
  (setq eglot-events-buffer-size 0)
  (setq eglot-ignored-server-capabilities '(:hoverProvider)))

; * xref
(use-package xref
  :general
  (general-def-leader
    "v ." 'xref-find-definitions-other-window
    "v :" 'xref-find-references))
