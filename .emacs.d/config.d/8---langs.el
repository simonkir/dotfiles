;;; -*- lexical-binding: t; -*-

; * tools
; ** magit
(use-package magit
  :general (general-def-leader
    "g" 'magit-file-dispatch
    "G" 'magit-dispatch)

  :config
  ;; enter insert mode if commit message is empty
  (add-hook 'git-commit-setup-hook #'(lambda () (when (looking-at-p "^$") (meow-insert))))

  (general-def magit-mode-map
    "<backtab>" 'magit-section-cycle-diffs
    "<tab>" 'magit-section-toggle
    "TAB" 'magit-section-toggle
    "x" 'magit-delete-thing
    "p" 'magit-push))

; ** eat
(use-package eat
  :general
  (general-def-leader
    "r f" 'sk:run-fish
    "r b" 'sk:run-bash
    "r p" 'sk:run-ipython)

  :config
  (setq eat-kill-buffer-on-exit t)

  (defun sk:run-ipython ()
    (interactive)
    (eat "/usr/bin/env ipython" t))

  (defun sk:run-fish ()
    (interactive)
    (eat "/usr/bin/env fish" t))

  (defun sk:run-bash ()
    (interactive)
    (eat "/usr/bin/env bash" t))

  (general-def '(eat-semi-char-mode-map eat-char-mode-map)
    "C-SPC" nil))

; ** calc
(use-package calc
  :config
  (setq calc-algebraic-mode 'total)
  (setq calc-multiplication-has-precedence nil))

; ** help major mode
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

; * langs
; ** fish
(use-package fish-mode)

; ** lua
(use-package lua-mode
  :config (setq lua-indent-level 4))

