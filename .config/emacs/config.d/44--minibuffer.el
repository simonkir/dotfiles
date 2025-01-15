;;; -*- lexical-binding: t; -*-

; * prompts
(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)

; * vertico
(use-package vertico
  :demand t
  :config
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
  (vertico-multiform-mode) ;; used by embark
  (vertico-indexed-mode))

(use-package vertico-posframe
  :demand t
  :after vertico
  :config
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  (setq vertico-posframe-parameters '((left-fringe . 4) (right-fringe . 4)))

  (setq vertico-posframe-truncate-lines t)
  (setq vertico-posframe-border-width 2)

  (vertico-posframe-mode))

; * embark
(use-package embark
  :general (general-def
    "C-." 'embark-act
    "C-s" 'embark-isearch-forward
    "C-r" 'embark-isearch-backward)

  :config
  (setq embark-help-key "?")
  (setq prefix-help-command #'embark-prefix-help-command)

  (setq embark-indicators
        '(embark-minimal-indicator
          embark-highlight-indicator
          embark-isearch-highlight-indicator))

  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))

  (general-def 'embark-become-file+buffer-map
    "r" 'consult-recent-file
    "B" 'consult-bookmark
    "b" 'consult-buffer
    "p" 'consult-project-buffer))

(use-package embark-consult
  :demand t
  :after embark)

; * marginalia
(use-package marginalia
  :demand t
  :config
  (general-def minibuffer-local-map "M-f" 'marginalia-cycle)
  (marginalia-mode))
