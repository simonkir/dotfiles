;;; -*- lexical-binding: t; -*-



(use-package calc
  :defer t
  :general
  ('normal 'override
     "SPC r C" 'calc
     "SPC r c" 'quick-calc)

  :config
  (setq calc-multiplication-has-precedence nil)

  (add-hook 'calc-mode-hook 'calc-algebraic-mode)

  (general-def 'normal calc-mode-map "SPC" nil) ;; unbind SPC for the following to work
  (general-def 'normal calc-mode-map :prefix "SPC SPC"
	"c" 'calc-evaluate
	"c" 'calc-convert-units
	"s" 'calc-solve-for
	"S" 'calc-poly-roots
	"d" 'calc-derivative
	"t" 'calc-taylor
	"i" 'calc-integral))
	;;"I" '(lambda () (interactive) (setq current-prefix-arg 4) (calc-integral))))
