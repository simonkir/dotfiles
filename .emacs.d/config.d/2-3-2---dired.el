;;; -*- lexical-binding: t; -*-



(use-package dired
  :defer t
  :general ('normal 'override "SPC f D" 'dired)
  :config
  (setq dired-dwim-target t) ;; when two windows are next to each other, move / copy files between them
  (general-def 'normal dired-mode-map
    "v" 'dired-view-file
    "h" 'dired-up-directory
    "l" 'dired-find-file
	"SPC" nil)
  (general-def 'normal dired-mode-map :prefix "SPC SPC"
	"d" 'dired-hide-details-mode
	"a" 'dired-omit-mode))



(use-package dired-x
  :defer t
  :general ('normal 'override "SPC f d" 'dired-jump)
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . dired-omit-mode))
