;;; -*- lexical-binding: t; -*-

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
  "d C" 'sk:cpwd)
