;;; -*- lexical-binding t; -*-

; * general settings
(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line

(setq mouse-wheel-scroll-amount '(5 ((shift) . hscroll)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(advice-add 'isearch-exit :after #'(lambda () (when isearch-forward (goto-char isearch-other-end))))

; * keybinds
(general-def
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

; * avy
(use-package avy
  :general (general-def 'meow-normal-state-keymap "g" 'avy-goto-char-timer))

; * outline mode
(use-package outline
  :hook (prog-mode . outline-minor-mode)
  :config
  (setq outline-minor-mode-cycle t)
  (add-hook 'prog-mode-hook #'(lambda () (setq-local outline-regexp (concat comment-start "+ *\\*+"))))

  (general-def-leader
    "v n" 'outline-next-visible-heading
    "v p" 'outline-previous-visible-heading
    "v f" 'outline-forward-same-level
    "v b" 'outline-backward-same-level
    "v a" 'outline-show-all
    "v l" 'outline-show-branches
    "v u" 'outline-up-heading
    "v v" 'outline-show-only-headings))

