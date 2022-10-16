;;; -*- lexical-binding: t; -*-



(use-package calc
  :bind (:map sk:leader-map ("c" . calc-dispatch))
  :config
  (setq calc-multiplication-has-precedence nil))
