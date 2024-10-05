;;; -*- lexical-binding: t; -*-

; * skcorrect
(use-package skcorrect
  :hook ((org-mode LaTeX-mode) . skcorrect-mode))

; * spell checking
(use-package jinx
  :general (general-def meow-normal-state-keymap
    "!" 'jinx-correct
    "?" 'jinx-mode)
  :config
  (setq-default jinx-languages "de_DE"))
