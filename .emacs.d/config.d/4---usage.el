;;; -*- lexical-binding: t; -*-

; * embark
(use-package embark
  :general (general-def
    "<menu>" 'embark-act
    "C-s" 'embark-isearch-forward)

  :config
  (setq embark-mixed-indicator-delay 1)

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

; * parentheses
; ** electric
(use-package electric
  :demand t
  :config
  (setq-default electric-indent-inhibit t)

  (electric-pair-mode)

  (add-to-list 'electric-pair-pairs '(8218 . 8216))  ;; ‚‘
  (add-to-list 'electric-pair-pairs '(8222 . 8220))) ;; „“

; ** skparens
(use-package skparens
  :demand t
  :config
  (general-def meow-normal-state-keymap
    "%" 'skparens-change
    "D" 'skparens-delete
    "S" 'skparens-insert
    "A" 'skparens-mark-outer
    "I" 'skparens-mark-inner))

; * indentation
; ** tab settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

; ** whitespace pkg
(general-def "M-SPC" 'delete-horizontal-space)

(use-package whitespace
  :demand t
  :config
  (setq whitespace-style '(trailing indentation space-before-tab space-after-tab))
  (setq whitespace-action '(auto-cleanup warn-if-read-only))

  (global-whitespace-mode))

; * yasnippet
(use-package yasnippet
  :demand t
  :config
  (general-def yas-minor-mode-map
    "<tab>" nil
    "TAB" nil)

  (yas-global-mode))

; * skcorrect
(use-package skcorrect
  :hook ((org-mode LaTeX-mode) . skcorrect-mode))

; * prompts
(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)

; * sk:functions
(defun sk:cpwd ()
  "print and copy current working directory to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD default-directory)
  (message "%s" default-directory))

(defun sk:cpfn ()
  "print and copy current file name to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD buffer-file-name)
  (message "%s" buffer-file-name))

(general-def-leader
  "d c" 'sk:cpfn
  "d C" 'sk:cpwd)
