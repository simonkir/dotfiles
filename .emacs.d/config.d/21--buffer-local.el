;;; -*- lexical-binding: t; -*-



(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line

(setq mouse-wheel-scroll-amount '(5 ((shift) . hscroll)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(advice-add 'isearch-exit :after #'(lambda () (when isearch-forward (setf (point) isearch-other-end))))



(use-package avy
  :general ('(normal visual) 'override :prefix "SPC a"
   "c" 'avy-goto-char-timer
   "h" 'avy-org-goto-heading-timer
   "w" 'avy-goto-word-or-subword-1
   "W" 'avy-goto-word))




(use-package follow
  :general ('normal 'override "SPC t f" 'follow-mode))
