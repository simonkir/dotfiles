;;; -*- lexical-binding: t; -*-

; * dired
(use-package dired
  :config
  (setq dired-dwim-target t) ;; when two windows are next to each other, move / copy files between them
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-listing-switches "-alh")

  (general-def 'dired-mode-map
    "i" 'dired-toggle-read-only
    "h" 'dired-up-directory
    "l" 'dired-find-file
    "r" 'dired-flag-garbage-files
    ")" 'dired-omit-mode))

(use-package dired-x
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . dired-omit-mode))
