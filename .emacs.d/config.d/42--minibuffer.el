;;; -*- lexical-binding: t; -*-

; * consult
(use-package consult
  :general
  (general-def-leader
    "b b" 'consult-buffer
    "b B" 'consult-project-buffer
    "w b" 'consult-buffer-other-window
    "f b" 'consult-bookmark
    "f r" 'consult-recent-file
    "v e" 'consult-flymake
    "v j" 'consult-outline)

  (general-def meow-normal-state-keymap
    "P" 'consult-yank-pop
    "M" 'consult-goto-line
    "v" 'consult-line))

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
  (vertico-indexed-mode))

; * vertico-posframe
(use-package vertico-posframe
  :demand t
  :after vertico
  :config
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  (setq vertico-posframe-truncate-lines nil)
  (vertico-posframe-mode))

; * marginalia
(use-package marginalia
  :demand t
  :config
  (general-def minibuffer-local-map "M-f" 'marginalia-cycle)
  (marginalia-mode))
