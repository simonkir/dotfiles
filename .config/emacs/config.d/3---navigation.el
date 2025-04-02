;;; -*- lexical-binding: t; -*-

; * consult
(use-package consult
; ** keybinds
  :general
  (general-def-leader
    "b b" 'consult-buffer
    "f b" 'consult-bookmark
    "f r" 'consult-recent-file
    "v e" 'consult-flymake
    "v j" 'consult-outline)

  (general-def meow-normal-state-keymap
    "P" 'consult-yank-pop
    "M" 'consult-goto-line
    "v" 'consult-line)

  :config
; ** general settings
  ;; (setq consult-narrow-key ">")
  (setq consult-widen-key "<")
  (setq consult-preview-key nil)

; ** consult-buffer
  (defun sk:file-visiting-buffer-list ()
    (let ((result '()))
      (dolist (buffer (buffer-list))
        (when (buffer-file-name buffer)
          (add-to-list 'result (buffer-name buffer))))
      result))

  (defun sk:vc-buffer-list ()
    (let ((result '()))
      (dolist (buffer (buffer-list))
        (when (string-prefix-p "magit" (buffer-name buffer))
          (add-to-list 'result (buffer-name buffer))))
      result))

  (defun sk:dired-buffer-list ()
    (let ((result '()))
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (when (derived-mode-p 'dired-mode)
           (add-to-list 'result (buffer-name buffer)))))
      result))

  (defvar sk:consult--source-file-visiting-buffer
    `( :name "File Visiting Buffer"
       :narrow ?f
       :hidden t
       :category buffer
       :face consult-buffer
       :state ,#'consult--buffer-state
       :history buffer-name-history
       :items ,#'sk:file-visiting-buffer-list ))

  (defvar sk:consult--source-vc-buffer
    `( :name "VC Buffer"
       :narrow ?g
       :hidden t
       :category buffer
       :face consult-buffer
       :state ,#'consult--buffer-state
       :history buffer-name-history
       :items ,#'sk:vc-buffer-list ))

  (defvar sk:consult--source-dired-buffer
    `( :name "Dired Buffer"
       :narrow ?d
       :hidden t
       :category buffer
       :face consult-buffer
       :state ,#'consult--buffer-state
       :history buffer-name-history
       :items ,#'sk:dired-buffer-list ))

  (setq consult-buffer-sources '(consult--source-buffer
                                 sk:consult--source-file-visiting-buffer
                                 sk:consult--source-vc-buffer
                                 sk:consult--source-dired-buffer
                                 consult--source-project-buffer-hidden
                                 consult--source-modified-buffer
                                 consult--source-hidden-buffer))

  (add-to-list 'consult-buffer-filter "\\*Async-native-compile-log\\*"))

; * xref
(use-package xref
  :general
  (general-def-leader
    "v ." 'xref-find-definitions-other-window
    "v :" 'xref-find-references))
