;;; -*- lexical-binding: t; -*-



; buffer-local ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line
(setq mouse-wheel-scroll-amount '(5 ((shift) . 20)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(general-def 'normal 'override
  "SPC t f" 'follow-mode)



; windows ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sk:split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun sk:split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(general-def '(normal visual) 'override :prefix "SPC w"
  "=" 'balance-windows
  "o" 'delete-other-windows
  "1" 'delete-other-windows
  "s" 'sk:split-and-follow-horizontally
  "v" 'sk:split-and-follow-vertically
 
  "h" 'evil-window-left
  "j" 'evil-window-down
  "k" 'evil-window-up
  "l" 'evil-window-right
  "c" 'evil-window-delete
  "C" 'kill-buffer-and-window)

(general-def 'normal 'override
  "SPC ," 'evil-window-next)

(general-def '(normal visual insert) 'override
  "C-SPC" 'evil-window-next)



; buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sk:kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(general-def '(normal visual insert) 'override
  ;;"C-w" 'bury-buffer ;; useful when using tab-line-mode
  "C-<tab>" 'next-buffer
  "<C-iso-lefttab>" 'previous-buffer)

(general-def '(normal visual) 'override :prefix "SPC b"
  "q" 'bury-buffer
  "h" 'previous-buffer
  "l" 'next-buffer
  "b" 'switch-to-buffer
  "k" 'sk:kill-current-buffer
  "K" 'kill-buffer-and-window)

(use-package ibuffer
  :defer t
  :general ('(normal visual) 'override "SPC b B" 'ibuffer))



; files ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def '(normal visual) 'override :prefix "SPC f"
  "f" 'find-file
  "F" 'find-file-read-only
  "p" 'find-file-at-point
  "R" 'revert-buffer
  "s" 'save-buffer
  "S" 'save-some-buffers)

(general-def '(normal visual) 'override
  "SPC s" 'save-buffer)



; misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; quitting
(general-def '(normal visual) 'override :prefix "SPC"
  "ESC" 'keyboard-escape-quit
  "q" 'save-buffers-kill-terminal
  "Q" 'save-buffers-kill-emacs)

; help
(general-def '(normal visual) 'override :prefix "SPC h"
  "f" 'describe-function
  "v" 'describe-variable
  "k" 'describe-key)
