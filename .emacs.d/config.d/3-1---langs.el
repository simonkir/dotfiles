;;; -*- lexical-binding: t; -*-



(use-package julia-mode
  :defer t
  :ensure t
  :general ('normal 'override "SPC r j" 'run-julia))



(use-package jupyter
  :defer t
  :ensure t)



(use-package calc
  :defer t
  :general ('normal 'override "SPC r C" 'calc))

(general-def 'normal 'override
  "SPC r c" 'quick-calc)
