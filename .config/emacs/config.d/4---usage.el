;;; -*- lexical-binding: t; -*-

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
  :general
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
(use-package whitespace
  :demand t
  :config
  (setq whitespace-style '(trailing indentation space-before-tab space-after-tab))
  (setq whitespace-action '(auto-cleanup warn-if-read-only))

  (general-def "M-SPC" 'just-one-space)

  (global-whitespace-mode))

; * yasnippet
(use-package yasnippet
  :demand t
  :config
  (general-def yas-minor-mode-map
    "<tab>" nil
    "TAB" nil)

  (yas-global-mode))

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
