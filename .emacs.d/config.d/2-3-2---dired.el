;;; -*- lexical-binding: t; -*-



(use-package dired
  :general ('normal 'override "SPC f D" 'dired)
  :config
  (setq dired-dwim-target t) ;; when two windows are next to each other, move / copy files between them
  (setq dired-kill-when-opening-new-dired-buffer t)

  (general-def '(normal visual) dired-mode-map
    "v" 'dired-view-file
    "h" 'dired-up-directory
    "l" 'dired-find-file
    "SPC" nil)

  (general-def '(normal visual) dired-mode-map :prefix "SPC SPC"
    "d" 'dired-hide-details-mode
    "a" 'dired-omit-mode))



(use-package dired-x
  :general ('normal 'override "SPC f d" 'dired-jump)
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . dired-omit-mode))
