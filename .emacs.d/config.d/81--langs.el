;;; -*- lexical-binding: t; -*-

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
