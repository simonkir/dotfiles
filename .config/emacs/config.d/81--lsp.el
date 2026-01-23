;;; -*- lexical-binding: t; -*-

; * eglot
(use-package eglot
  :general
  (general-def-leader
    "l l" 'eglot
    "l L" 'eglot-shutdown
    "l a" 'eglot-code-action
    "l r" 'eglot-rename)

  :config
  (setq eglot-autoshutdown t)
  (setq eglot-events-buffer-size 0)

  ;; general server settings
  (setq eglot-ignored-server-capabilities '(:hoverProvider)) ;; dont show descriptions in minibuffer

  ;; server-specific settings
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) .
                 ("jedi-language-server" :initializationOptions
                  (:completion (:disableSnippets t))))))

