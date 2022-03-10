;;; -*- lexical-binding: t; -*-



(use-package julia-mode
  :ensure t
  :defer t
  :general ('(normal visual) 'override "SPC r j" 'run-julia))



(use-package gnuplot
  :ensure t
  :defer t)



(use-package jupyter
  :ensure t
  :defer t)
