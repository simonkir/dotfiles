;;; -*- lexical-binding: t; -*-

; * magit
(use-package magit
  :general (general-def-leader
    "g" 'magit-file-dispatch
    "G" 'magit-dispatch)

  :config
  ;; enter insert mode if commit message is empty
  (add-hook 'git-commit-setup-hook
            #'(lambda ()
                (interactive)
                (when (looking-at-p "^$")
                  (meow-insert))))

  (general-def magit-mode-map
    "<backtab>" 'magit-section-cycle-diffs
    "<tab>" 'magit-section-toggle
    "TAB" 'magit-section-toggle
    "x" 'magit-delete-thing
    "p" 'magit-push))

; * eat
(use-package eat
  :general (general-def-leader "r t" 'eat)
  :config (general-def 'eat-semi-char-mode-map "C-SPC" nil))

; * maxima
(use-package maxima
  :general (general-def-leader "r m" 'maxima)
  :init
  (add-to-list 'auto-mode-alist (cons "\\.mac\\'" 'maxima-mode))
  (add-to-list 'interpreter-mode-alist (cons "maxima" 'maxima-mode)))

; * calc
(use-package calc
  :config
  (setq calc-algebraic-mode 'total)
  (setq calc-multiplication-has-precedence nil))

; * gnuplot
(use-package gnuplot)

; * lua
(use-package lua-mode
  :config (setq lua-indent-level 4))

; * help major mode
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

