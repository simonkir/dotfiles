;;; -*- lexical-binding: t; -*-



(blink-cursor-mode -1)



(defun sk:print-time ()
  (interactive)
  (message "%s" (format-time-string "%a, %d.%m.%Y (KW %W), %H:%M:%S %Z")))
