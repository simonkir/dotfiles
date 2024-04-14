;;; -*- lexical-binding: t; -*-

; * sk:functions
; ** definitions
(defun sk:kill-current-buffer ()
  "kills currently visited buffer"
  (interactive)
  (kill-buffer (current-buffer)))

; ** keybinds
(general-def-leader
  "b b" 'switch-to-buffer
  "b k" 'sk:kill-current-buffer
  "b K" 'kill-buffer-and-window)

; * auto-revert-mode
(global-auto-revert-mode)

; * uniquify
(defun sk:uniquify (base extra-string)
  (concat (mapconcat #'identity extra-string "/") ": " base))

(setq uniquify-buffer-name-style 'sk:uniquify)
