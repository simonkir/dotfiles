;;; -*- lexical-binding: t; -*-



(use-package transpose-frame
  :ensure t
  :defer t
  :general ('normal 'override :prefix "SPC w"
	"w" 'transpose-frame
	"F" 'flip-frame
	"f" 'flop-frame))
