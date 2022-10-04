;;; -*- lexical-binding: t; -*-



(use-package calc
  :general ('normal 'override "SPC c" 'calc-dispatch)
  :config
  (setq calc-multiplication-has-precedence nil)

  (general-def '(normal visual) calc-mode-map "SPC" nil) ;; unbind SPC for the following to work
  (general-def '(normal visual) calc-mode-map
    "SPC SPC e" 'calc-evaluate
    "SPC SPC c" 'calc-convert-units
    "SPC SPC s" 'calc-solve-for
    "SPC SPC S" 'calc-poly-roots
    "SPC SPC d" 'calc-derivative
    "SPC SPC t" 'calc-taylor
    "SPC SPC i" 'calc-integral
    "SPC SPC I" 'calc-num-integral))
