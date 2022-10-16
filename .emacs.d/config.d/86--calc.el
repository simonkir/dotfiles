;;; -*- lexical-binding: t; -*-



(use-package calc
  :general (general-def-leader "SPC c" 'calc-dispatch)
  :config
  (setq calc-multiplication-has-precedence nil))
