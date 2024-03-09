;;; -*- lexical-binding: t; -*-

; * sk:functions
; ** definitions
(setq sk:ignored-buffers-regexp "\\(^\\s-*\\*+\\)\\|\\(^magit\\)\\|\\(^\\s-*tq-temp-epdfinfo\\)")
(setq sk:unignored-buffers-regexp "\\*maxima\\*\\|\\*Org Agenda\\*")

(defun sk:buffer-list ()
  "returns buffer-list without unimportant buffers (specified in `sk:ignored-buffers-regexp')"
  (let ((buffers (mapcar 'buffer-name (buffer-list))))
    (dolist (element buffers)
      (when (and (not (string-match-p sk:unignored-buffers-regexp element))
                 (string-match-p sk:ignored-buffers-regexp element))
        (setq buffers (remove element buffers)))) ;; ensure element is deleted from buffers
    (sort buffers 'string<)))

(defun sk:switch-to-buffer ()
  (interactive)
  (switch-to-buffer (completing-read "Switch to buffer: " (sk:buffer-list)) t))

(defun sk:kill-current-buffer ()
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

