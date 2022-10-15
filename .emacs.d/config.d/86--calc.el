;;; -*- lexical-binding: t; -*-



(use-package calc
  :bind (:map mode-specific-map ("#" . calc-dispatch))
  :config
  (setq calc-multiplication-has-precedence nil))
