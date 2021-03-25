;;; -*- lexical-binding: t; -*-



; buffer-local ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line

(general-def 'normal 'override
 "SPC t f" 'follow-mode)

(use-package avy
  :ensure t
  :general ('(normal visual) 'override :prefix "SPC a"
            "a" 'avy-goto-word-or-subword-1
            "c" 'avy-goto-char-timer
            "w" 'avy-goto-word-or-subword-1
            "W" 'avy-goto-word
            "l" 'avy-goto-line
            "j" 'avy-goto-line-below
            "k" 'avy-goto-line-above))



; windows ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(general-def 'normal 'override :prefix "SPC w"
 "=" 'balance-windows
 "o" 'delete-other-windows
 "1" 'delete-other-windows
 "s" 'split-and-follow-horizontally
 "v" 'split-and-follow-vertically

 "h" 'evil-window-left
 "j" 'evil-window-down
 "k" 'evil-window-up
 "l" 'evil-window-right
 "w" 'evil-window-next
 "c" 'evil-window-delete
 "C" 'kill-buffer-and-window)

(general-def 'normal 'override
 "SPC ," 'evil-window-next)



; buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(general-def 'normal 'override :prefix "SPC b"
 "q" 'quit-window
 "k" 'kill-current-buffer
 "K" 'kill-buffer-and-window)

(use-package ibuffer
  :general ('normal 'override "SPC b B" 'ibuffer))



; files ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def 'normal 'override :prefix "SPC f"
 "f" 'find-file
 "F" 'find-file-read-only
 "R" 'revert-buffer
 "s" 'save-buffer
 "S" 'save-some-buffers)

(general-def 'normal
  "g r" 'revert-buffer)

(general-def 'normal 'override
 "SPC s" 'save-buffer)



(use-package bookmark
  :demand t

  :config
  (general-def 'normal 'override
    "SPC f b" 'ido-bookmark-jump)

  (general-def 'normal 'override :prefix "SPC f B"
    "B" 'edit-bookmarks
    "d" 'bookmark-delete
    "r" 'bookmark-rename
    "R" 'bookmark-relocate
    "s" 'bookmark-set))



(use-package recentf
  :demand t

  :custom
  (recentf-max-saved-items 100)

  :config
  (recentf-mode t)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/*"))
  (general-def 'normal 'override "SPC f r" 'recentf-ido-find-file))



(use-package dired
  :defer t

  :custom
  (dired-dwim-target t) ;; when two windows are next to each other, move / copy files between them

  :config
  (general-def 'normal dired-mode-map
    "v" 'dired-view-file
    "h" 'dired-up-directory
    "l" 'dired-find-file)

  :general ('normal 'override :prefix "SPC f"
                    "D" 'dired))



(use-package dired-x
  :defer t
  
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . dired-omit-mode)

  :general ('normal 'override :prefix "SPC f"
                    "d" 'dired-jump))



; quitting
(general-def 'normal 'override :prefix "SPC"
 "ESC" 'keyboard-escape-quit
 "q" 'save-buffers-kill-terminal
 "Q" 'save-buffers-kill-emacs)

; help
(general-def 'normal 'override :prefix "SPC h"
 "f" 'describe-function
 "v" 'describe-variable
 "k" 'describe-key)



; config operations ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun sk:config-visit ()
;;   (interactive)
;;   (find-file "~/.emacs.d/conf.org"))

(defun sk:config-reload ()
  (interactive)
  (load-directory "~/.emacs.d/config.d"))

(general-def 'normal 'override :prefix "SPC c"
 ;; "v" 'sk:config-visit
 ;; "e" 'sk:config-visit
 "r" 'sk:config-reload)
