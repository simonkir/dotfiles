;;; -*- lexical-binding: t; -*-

; * skcorrect
(use-package skcorrect
  :hook ((org-mode LaTeX-mode) . skcorrect-mode))
