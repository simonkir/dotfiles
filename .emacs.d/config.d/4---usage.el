;;; -*- lexical-binding: t; -*-



(blink-cursor-mode -1)



(defun sk:print-time ()
  (interactive)
  (message "%s" (format-time-string "%a, %d.%m.%Y (KW %W), %H:%M:%S %Z")))



(defun sk:cpwd ()
  "print and copy current working directory to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD default-directory)
  (message "%s" default-directory))



(general-def-leader
  "d c" 'sk:cpwd
  "d t" 'sk:print-time)
