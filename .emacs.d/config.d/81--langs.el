;;; -*- lexical-binding: t; -*-



(use-package eat
  :general (general-def-leader "r t" 'eat))



(use-package maxima
  :init
  (add-to-list 'auto-mode-alist (cons "\\.mac\\'" 'maxima-mode))
  (add-to-list 'interpreter-mode-alist (cons "maxima" 'maxima-mode))

  :general (general-def-leader "r m" 'maxima))



(use-package calc
  :config
  (setq calc-algebraic-mode 'total)
  (setq calc-multiplication-has-precedence nil))



(use-package gnuplot)



(use-package lua-mode
  :config (setq lua-indent-level 4))
