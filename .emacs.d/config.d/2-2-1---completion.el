;;; -*- lexical-binding: t; -*-



(use-package hippie-exp
  :demand t
  :config
  (setq tab-always-indent t)

  (defun sk:insert-tab-key ()
    (interactive)
    (if (string-match-p "[[:alnum:]]" (char-to-string (preceding-char)))
        (call-interactively 'hippie-expand)
      (call-interactively 'indent-for-tab-command)))

  (general-def 'insert 'override
    "TAB" 'sk:insert-tab-key))
