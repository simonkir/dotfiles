;;; -*- lexical-binding: t; -*-



(use-package calc
  :general (general-def-leader "c" 'calc-dispatch)
  :config
  (setq calc-multiplication-has-precedence nil))
