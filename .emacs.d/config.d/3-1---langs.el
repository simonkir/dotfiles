;;; -*- lexical-binding: t; -*-



(use-package julia-mode
  :ensure t
  :defer t
  :general ('normal 'override "SPC r j" 'run-julia))



(use-package jupyter
  :ensure t
  :defer t)
