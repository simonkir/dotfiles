;;; -*- lexical-binding: t; -*-



(use-package hippie-exp
  :demand t
  :config
  (setq tab-always-indent t)
  (setq hippie-expand-try-functions-list
        '(try-complete-file-name-partially
          try-complete-file-name
          try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol))

  (defun sk:insert-backtab-key ()
    (interactive)
    (cond ((and (derived-mode-p 'org-mode)
                (member (nth 0 (org-element-at-point)) '(table-row table)))
           (call-interactively 'org-table-previous-field))
          (t (hippie-expand 0))))

  (defun sk:insert-tab-key ()
    (interactive)
    (cond ((and (derived-mode-p 'org-mode)
                (member (nth 0 (org-element-at-point)) '(table-row table)))
           (call-interactively 'org-table-next-field))
          ((when yas-minor-mode
             (let ((yas-fallback-behavior 'return-nil))
               (yas-expand))))
          ((and (texmathp)
                (not (derived-mode-p 'prog-mode)))
           (call-interactively 'cdlatex-tab))
          ((string-match-p "[[:alnum:]]" (char-to-string (preceding-char)))
           (call-interactively 'hippie-expand))
          (t
           (call-interactively 'indent-for-tab-command))))

  (general-def 'insert 'override
    "<backtab>" 'sk:insert-backtab-key
    "TAB" 'sk:insert-tab-key))
