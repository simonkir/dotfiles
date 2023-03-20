;;; -*- lexical-binding t; -*-



(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line

(setq mouse-wheel-scroll-amount '(5 ((shift) . hscroll)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(advice-add 'isearch-exit :after #'(lambda () (when isearch-forward (setf (point) isearch-other-end))))



;; meow behaves weridly without these deifinitions
;; see variable-help for details

(setq meow--kbd-forward-char "C-x 9 f")
(setq meow--kbd-backward-char "C-x 9 b")
(setq meow--kbd-yank "C-x 9 y")

(general-def
  "C-x 9 f" 'forward-char
  "C-x 9 b" 'backward-char
  "C-x 9 y" 'yank
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
  :general (:keymaps 'meow-normal-state-keymap "g" 'avy-goto-char-timer))
