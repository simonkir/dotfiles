;; -*- lexical-binding: t; -*-

; * yasnippet
(use-package yasnippet
  :demand t
  :config
  (general-def yas-minor-mode-map
    "<tab>" nil
    "TAB" nil)

  (yas-global-mode))

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

; * checkers
; ** skcorrect
(use-package skcorrect
  :hook ((org-mode LaTeX-mode) . skcorrect-mode))

; ** spell checking
(use-package jinx
  :general (general-def meow-normal-state-keymap
    "!" 'jinx-correct
    "?" 'jinx-mode)
  :config
  (setq-default jinx-languages "de_DE"))

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

