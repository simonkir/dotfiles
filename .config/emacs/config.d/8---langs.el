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

  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (setq magit-format-file-function #'magit-format-file-nerd-icons)

  (general-def magit-mode-map
    "<backtab>" 'magit-section-cycle-diffs
    "<tab>" 'magit-section-toggle
    "TAB" 'magit-section-toggle
    "x" 'magit-delete-thing
    "p" 'magit-push))

(use-package transient-posframe
  :demand t
  :after magit
  :config
  (setq transient-posframe-poshandler #'posframe-poshandler-window-bottom-center)
  (setq transient-posframe-parameters '((left-fringe . 6) (right-fringe . 6)))
  (setq transient-posframe-min-width nil)
  (setq transient-posframe-min-height nil)

  (setq transient-posframe-border-width 2)
  (set-face-attribute 'transient-posframe-border nil :inherit 'vertico-posframe-border :background nil)

  (transient-posframe-mode))

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

; ** dictionary
(use-package dictionary
  :config
  (setq dictionary-server "dict.org")
  (setq dictionary-use-single-buffer t))

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
  "p" 'help-go-back
  "q" 'quit-window
  "Q" 'bury-buffer)

; * langs
; ** epub
(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

  :config
  (setq nov-header-line-format nil)
  (setq nov-variable-pitch nil)
  (setq nov-text-width t)

  (add-hook 'nov-mode-hook 'emojify-mode)

  (general-def 'nov-mode-map
    "t" nil
    "r" nil
    "g" 'avy-goto-char-timer
    "f" 'sk:scroll-page-down
    "b" 'sk:scroll-page-up
    "e" 'sk:scroll-line-down
    "y" 'sk:scroll-line-up
    "d" 'dictionary-search
    "D" 'dictionary-match-words
    "§" 'count-words
    "o" 'nov-goto-toc
    "h" 'meow-left
    "l" 'meow-right))

; ** fish
(use-package fish-mode)

; ** lua
(use-package lua-mode
  :config (setq lua-indent-level 4))

; ** markdown
(use-package markdown-mode)

