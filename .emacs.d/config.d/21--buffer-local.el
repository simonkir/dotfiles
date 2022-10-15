;;; -*- lexical-binding t; -*-



(setq scroll-conservatively 100)
(setq scroll-margin 5) ;; begin scrolling when the cursor is 5 lines above the last displayed line

(setq mouse-wheel-scroll-amount '(5 ((shift) . hscroll)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(advice-add 'isearch-exit :after #'(lambda () (when isearch-forward (setf (point) isearch-other-end))))



;; TODO unbind keys in global map
;;   → C-f and C-h behave weirdly when bound and moving with hjkl
;;(bind-keys
;;  ("C-f" . scroll-up)
;;  ("C-b" . scroll-down)
;;  ("C-e" . scroll-up-line)
;;  ("C-y" . scroll-down-line)
;;
;;  ("C-w" . delete-backward-char)
;;
;;  ("C-h" . backward-char)
;;  ("C-j" . next-line)
;;  ("C-k" . previous-line)
;;  ("C-l" . forward-char))



;;(use-package avy
;;  :general ('(normal visual) 'override
;;   "SPC a c" 'avy-goto-char-timer
;;   "SPC a h" 'avy-org-goto-heading-timer
;;   "SPC a w" 'avy-goto-word-or-subword-1
;;   "SPC a W" 'avy-goto-word))

;;(meow-normal-define-key
;; '("g" . avy-goto-char-timer))

;;(bind-key "g" 'avy-goto-char-timer meow-normal-state-keymap)

(use-package avy
  :bind (:map meow-normal-state-keymap
         ("g" . 'avy-goto-char-timer)))



;;(use-package follow
;;  :general ('normal 'override "SPC t f" 'follow-mode))

(use-package follow
  :bind (:map mode-specific-map
         ("t f" . follow-mode)))
