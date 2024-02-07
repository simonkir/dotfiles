;;; -*- lexical-binding: t; -*-



(use-package eat
  :general (general-def-leader "r t" 'eat)
  :config (general-def 'eat-semi-char-mode-map "C-SPC" nil))



(use-package maxima
  :general (general-def-leader "r m" 'maxima)
  :init
  (add-to-list 'auto-mode-alist (cons "\\.mac\\'" 'maxima-mode))
  (add-to-list 'interpreter-mode-alist (cons "maxima" 'maxima-mode)))



(use-package calc
  :config
  (setq calc-algebraic-mode 'total)
  (setq calc-multiplication-has-precedence nil))



(use-package gnuplot)



(use-package lua-mode
  :config (setq lua-indent-level 4))
