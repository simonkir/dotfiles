;;; -*- lexical-binding: t; -*-

; * sk:functions
(defun sk:kill-this-buffer ()
  "unconditionally kill the current buffer"
  (interactive)
  (kill-buffer (current-buffer)))

(general-def-leader
  ;;"b b" nil ;; reserved for consult
  "b k" 'sk:kill-this-buffer
  "b K" 'kill-buffer-and-window
  "b q" 'bury-buffer)

; * uniquify
(defun sk:uniquify (base extra-string)
  (concat (mapconcat #'identity extra-string "/") ": " base))

(setq uniquify-buffer-name-style 'sk:uniquify)

