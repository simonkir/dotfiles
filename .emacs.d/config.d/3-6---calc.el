;;; -*- lexical-binding: t; -*-



(use-package calc
  :defer t
  :general ('normal 'override
     "SPC r c" 'calc
     "SPC r C" 'quick-calc)

  :config
  (setq calc-multiplication-has-precedence nil)
  ;;(add-hook 'calc-mode-hook 'calc-algebraic-mode)

  (general-def 'normal calc-mode-map "SPC" nil) ;; unbind SPC for the following to work
  (general-def 'normal calc-mode-map :prefix "SPC SPC"
	"e" 'calc-evaluate
	"c" 'calc-convert-units
	"s" 'calc-solve-for
	"S" 'calc-poly-roots
	"d" 'calc-derivative
	"t" 'calc-taylor
	"i" 'calc-integral
	"I" 'calc-num-integral))
