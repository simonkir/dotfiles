;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



; help ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def-leader
  "h" 'describe-symbol
  "H" 'describe-key)

(general-def help-mode-map
  "<escape>" 'meow-cancel-selection
  "h" 'meow-left
  "l" 'meow-right
  "H" 'help-go-back
  "L" 'help-go-forward
  "n" 'help-go-forward
  "p" 'help-go-back)



; helper functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sk:print-time ()
  (interactive)
  (message "%s" (format-time-string "%a, %d.%m.%Y (KW %W), %H:%M:%S %Z")))



(defun sk:cpwd ()
  "print and copy current working directory to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD default-directory)
  (message "%s" default-directory))

(defun sk:cpfn ()
  "print and copy current file name to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD buffer-file-name)
  (message "%s" buffer-file-name))



(general-def-leader
  "d c" 'sk:cpfn
  "d C" 'sk:cpwd
  "d t" 'sk:print-time)
