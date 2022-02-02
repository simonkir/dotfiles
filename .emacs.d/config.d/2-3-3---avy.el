;;; -*- lexical-binding: t; -*-



(use-package avy
  :ensure t
  :general
  ('(normal visual) 'override :prefix "SPC a"
   "c" 'avy-goto-char-timer
   "h" 'avy-org-goto-heading-timer
   "w" 'avy-goto-word-or-subword-1
   "W" 'avy-goto-word))
