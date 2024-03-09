;;; -*- lexical-binding: t; -*-

; * keybinds
(general-def-leader
  "f f" 'find-file
  "f R" 'revert-buffer-quick
  "f s" 'save-buffer
  "s"   'save-buffer)

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

; * recentf
(use-package recentf
  :demand t
  :config
  (setq recentf-max-saved-items 300)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/elpa/*"))
  (add-to-list 'recentf-exclude (expand-file-name "/usr/share/emacs/*"))
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*org.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*misc.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*glossar.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*aufgaben.tex")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*aufgaben.pdf")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*mitschrieb.tex")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*mitschrieb.pdf")

  (defun sk:recentf-find-file ()
    "Find a recent file using completing-read."
    (interactive)
    (let ((file (completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  (general-def-leader
    "f r" 'sk:recentf-find-file)

  (recentf-mode t))

; * bookmark
(use-package bookmark
  :demand t
  :config
  ;; always save bookmarks after changes have been made
  (setq bookmark-save-flag 1)

  (general-def-leader
    "f b" 'bookmark-jump))
