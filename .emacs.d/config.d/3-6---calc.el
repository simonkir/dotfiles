;;; -*- lexical-binding: t; -*-



(use-package calc
  :general ('normal 'override
     "SPC c" 'calc-dispatch)

  :config
  (setq calc-multiplication-has-precedence nil)

  (general-def '(normal visual) calc-mode-map "SPC" nil) ;; unbind SPC for the following to work
  (general-def '(normal visual) calc-mode-map :prefix "SPC SPC"
    "e" 'calc-evaluate
    "c" 'calc-convert-units
    "s" 'calc-solve-for
    "S" 'calc-poly-roots
    "d" 'calc-derivative
    "t" 'calc-taylor
    "i" 'calc-integral
    "I" 'calc-num-integral))
