;;; -*- lexical-binding t; -*-



(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line

(setq mouse-wheel-scroll-amount '(5 ((shift) . hscroll)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(advice-add 'isearch-exit :after #'(lambda () (when isearch-forward (setf (point) isearch-other-end))))



(setq meow--kbd-forward-char "C-x f")
(setq meow--kbd-backward-char "C-x b")

(general-def
  "C-x f" 'forward-char
  "C-x b" 'backward-char
  "C-f" 'scroll-up
  "C-b" 'scroll-down
  "C-e" 'scroll-up-line
  "C-y" 'scroll-down-line)
  
(general-def meow-insert-state-keymap
  "C-e" 'delete-backward-char
  "C-w" 'backward-kill-word
  "C-h" 'backward-char
  "C-j" 'next-line
  "C-k" 'previous-line
  "C-l" 'forward-char)



(use-package avy
  :general (:keymaps 'meow-normal-state-keymap "q" 'avy-goto-char-timer))



(use-package follow
  :general (general-def-leader "SPC t f" 'follow-mode))
