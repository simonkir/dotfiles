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

; ** eww
(use-package eww
  :config
  (setq eww-search-prefix "http://frogfind.com/?q="))

; ** eat
(use-package eat
  :general
  (general-def-leader
    "r t" 'sk:run-fish
    "r p" 'sk:run-ipython
    "r m" 'sk:run-maxima)

  :config
  (setq eat-kill-buffer-on-exit t)

  (defun sk:run-ipython ()
    (interactive)
    (eat "/usr/bin/env ipython" t))

  (defun sk:run-fish ()
    (interactive)
    (eat "/usr/bin/env fish" t))

  (defun sk:run-maxima ()
    (interactive)
    (eat "/usr/bin/env maxima") t)

  (general-def '(eat-semi-char-mode-map eat-char-mode-map)
    "C-SPC" nil))

; ** maxima
(use-package maxima
  :init
  (add-to-list 'auto-mode-alist (cons "\\.mac\\'" 'maxima-mode))
  (add-to-list 'interpreter-mode-alist (cons "maxima" 'maxima-mode)))

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

