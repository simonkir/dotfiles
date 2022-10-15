;;; -*- lexical-binding: t; -*-



(use-package dired
  :config
  (setq dired-dwim-target t) ;; when two windows are next to each other, move / copy files between them
  (setq dired-kill-when-opening-new-dired-buffer t)

  (bind-keys :map dired-mode-map
    ("h" . dired-up-directory)
    ("l" . dired-find-file)))



(use-package dired-x
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . dired-omit-mode))
