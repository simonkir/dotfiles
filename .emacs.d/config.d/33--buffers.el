;;; -*- lexical-binding: t; -*-

; * sk:functions
; ** definitions
(defun sk:switch-to-buffer ()
  "interactively switch to buffer in 'centaur-tabs-buffer-list'"
  (interactive)
  (switch-to-buffer
   (completing-read
    "Switch to buffer: "
    (mapcar (lambda (arg) (buffer-name arg)) (centaur-tabs-buffer-list)))
   t))

(defun sk:kill-current-buffer ()
  "kills currently visited buffer"
  (interactive)
  (kill-buffer (current-buffer)))

; ** keybinds
(general-def-leader
  "b b" 'sk:switch-to-buffer
  "b B" 'switch-to-buffer
  "b k" 'sk:kill-current-buffer
  "b K" 'kill-buffer-and-window)

; * auto-revert-mode
(global-auto-revert-mode)

; * uniquify
(defun sk:uniquify (base extra-string)
  (concat base " (" (mapconcat #'identity extra-string "/") ")"))

(setq uniquify-buffer-name-style 'sk:uniquify)
