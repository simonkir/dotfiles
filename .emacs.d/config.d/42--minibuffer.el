;;; -*- lexical-binding: t; -*-

; * embark
(use-package embark
  :general (general-def
    "C-." 'embark-act
    "C-s" 'embark-isearch-forward)

  :config
  (setq embark-mixed-indicator-delay 0)

  (general-def 'embark-become-file+buffer-map
    "r" 'consult-recent-file
    "B" 'consult-bookmark
    "b" 'consult-buffer
    "p" 'consult-project-buffer)

  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
  (vertico-multiform-mode))

(use-package embark-consult
  :demand t
  :after embark)

; * vertico
(use-package vertico
  :demand t
  :config
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)

  (setq completion-styles '(basic partial-completion substring initials flex))
  (setq completion-auto-help 'lazy)

  (setq vertico-preselect 'first)

  (general-def vertico-map
    "C-w" 'vertico-directory-delete-word
    "C-<backspace>" 'vertico-directory-delete-word
    "<backspace>" 'vertico-directory-delete-char
    "<S-return>" 'vertico-exit-input
    "<return>" 'vertico-directory-enter
    "<tab>" 'minibuffer-complete
    "C-j" 'vertico-next
    "C-k" 'vertico-previous)

  (vertico-mode)
  (vertico-indexed-mode))

; * vertico-posframe
(use-package vertico-posframe
  :demand t
  :after vertico
  :config
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  (vertico-posframe-mode))

; * marginalia
(use-package marginalia
  :demand t
  :config
  (general-def minibuffer-local-map "M-f" 'marginalia-cycle)
  (marginalia-mode))
