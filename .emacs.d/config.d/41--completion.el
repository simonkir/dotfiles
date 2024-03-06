;;; -*- lexical-binding: t; -*-

; * hippie-exp
(use-package hippie-exp
  :demand t
  :config
; ** general settings
  (setq tab-always-indent t)
  (setq hippie-expand-try-functions-list
        '(try-complete-file-name-partially
          try-complete-file-name
          try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol))

; ** tab / backtab keybinds
  (defun sk:insert-backtab-key ()
    (interactive)
    (cond ((and (derived-mode-p 'org-mode)
                (member (nth 0 (org-element-at-point)) #'(table-row table)))
           (call-interactively #'org-table-previous-field))
          (t (hippie-expand 0))))

  (defun sk:insert-tab-key ()
    (interactive)
    (cond
     ;; org-table tabbing
     ;; before snippet to avoid unwanted interferences
     ((and (derived-mode-p 'org-mode)
           (member (nth 0 (org-element-at-point)) #'(table-row table)))
      (call-interactively #'org-table-next-field))
     ;; snippet exapnsion
     ((when yas-minor-mode
        (let ((yas-fallback-behavior 'return-nil))
          (when (yas-expand)
            (run-hooks 'post-self-insert-hook)))))
     ;; completion (depending in major-mode)
     ((string-match-p "[[:alnum:]}]" (char-to-string (preceding-char)))
      (cond
       ((and (derived-mode-p 'latex-mode)
             (not (derived-mode-p 'prog-mode))
             (texmathp))
        (call-interactively #'cdlatex-tab))
       ((derived-mode-p 'maxima-mode) (call-interactively #'maxima-complete))
       (t (call-interactively #'hippie-expand))))
     ;; indentation
     (t
      (call-interactively #'indent-for-tab-command))))

  (general-def meow-insert-state-keymap
    "<tab>"     'sk:insert-tab-key
    "<backtab>" 'sk:insert-backtab-key))
