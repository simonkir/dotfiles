;;; -*- lexical-binding: t; -*-



(use-package transpose-frame
  :ensure t
  :defer t
  :general ('(normal visual) 'override :prefix "SPC w"
    "w" 'transpose-frame
    "r" 'rotate-frame-clockwise
    "R" 'rotate-frame-anticlockwise
    "F" 'flip-frame
    "f" 'flop-frame))
