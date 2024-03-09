;;; -*- lexical-binding: t; -*-

; * in-buffer completion
; ** hippie-exp
(use-package hippie-exp
  :demand t
  :config
; *** general settings
  (setq tab-always-indent t)
  (setq hippie-expand-try-functions-list
        '(try-complete-file-name-partially
          try-complete-file-name
          try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol))

; *** tab / backtab keybinds
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

; * minibuffer completion
; ** icomplete
(use-package icomplete
  :demand t
  :config
; *** general settings
  ;; needed because icomplete--fido-mode-setup overwrites default settings
  (add-hook 'icomplete-minibuffer-setup-hook
            #'(lambda () (setq-local completion-styles '(basic partial-completion substring initials flex))))

  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)
  (setq completion-ignore-case t)
  (setq completion-auto-help 'lazy)
  (setq icomplete-compute-delay 0)

  (set-face-attribute 'icomplete-selected-match nil :inherit 'default :weight 'bold :foreground "#98be65")

; *** keybinds
  (general-def 'icomplete-minibuffer-map
    "C-<return>" 'icomplete-fido-ret
    "S-<return>" 'icomplete-fido-exit
    "C-d" 'icomplete-fido-kill
    "C-j" 'icomplete-forward-completions
    "C-k" 'icomplete-backward-completions)

  (general-def-leader
    "X" 'eval-expression)

; *** fido mode
  (fido-mode)
  (fido-vertical-mode))
