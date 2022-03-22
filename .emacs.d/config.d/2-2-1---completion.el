;;; -*- lexical-binding: t; -*-



(use-package hippie-exp
  :demand t
  :config
  (setq tab-always-indent t)

  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)

  (defun sk:hippie-unexpand ()
    (interactive)
    (hippie-expand 0))

  (defun sk:insert-tab-key ()
    (interactive)
    (cond ((and (derived-mode-p 'org-mode) (member (nth 0 (org-element-at-point)) '(table-row table)))
           (call-interactively 'org-table-next-field))
          ((string-match-p "[[:alnum:]]" (char-to-string (preceding-char)))
           (call-interactively 'hippie-expand))
          (t (call-interactively 'indent-for-tab-command))))

  (general-def 'insert 'override
    "<backtab>" 'sk:hippie-unexpand
    "TAB" 'sk:insert-tab-key))
