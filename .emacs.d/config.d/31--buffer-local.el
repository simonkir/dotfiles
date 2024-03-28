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
  :hook ((prog-mode conf-mode) . outline-minor-mode)
  :config
  (setq outline-minor-mode-cycle t)

  (defun sk:setup-outline-mode ()
    "sets up correct outline-regexp and outline-level definitions according to major-mode

should be called after changing the major mode"
    (let ((sk-outline-regexp (concat (string-trim comment-start) "+ *\\*+"))
          (sk-outline-level #'outline-level))
      (setq-local outline-regexp sk-outline-regexp)
      (setq-local outline-level sk-outline-level)))

  (add-hook 'prog-mode-hook #'sk:setup-outline-mode)
  (add-hook 'conf-mode-hook #'sk:setup-outline-mode)

  (general-def-leader
    "v n" 'outline-next-visible-heading
    "v p" 'outline-previous-visible-heading
    "v f" 'outline-forward-same-level
    "v b" 'outline-backward-same-level

    "v a" 'outline-show-all
    "v h" 'outline-show-only-headings
    "v l" 'outline-show-branches
    "v o" 'outline-hide-other
    "v u" 'outline-up-heading
    "v v" 'outline-hide-sublevels))

; * narrowing
(defun sk:narrow-or-widen ()
  "narrows or widens based on object under cursor and active region"
  (interactive)
  (cond
   ;; org: close editing buffer
   ((string-match-p "Org Src" (buffer-name (current-buffer))) (org-edit-src-exit))
   ((string-match-p "Formula" (buffer-name (current-buffer))) (org-table-fedit-finish '(4)))

   ;; org: edit element in special buffer
   ((and (derived-mode-p 'org-mode)
         (member (car (org-element-context))
                 '(src-block
                   latex-environment
                   latex-fragment
                   table-cell
                   table-row)))
    (org-edit-special))

   ;; narrow-to-region commands
   ((buffer-narrowed-p) (widen))
   ((region-active-p) (narrow-to-region (region-beginning) (region-end)))
   ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
   ((derived-mode-p 'prog-mode) (narrow-to-defun))

   ;; fallback
   (t (message "no suitable narrowing possible"))))

(general-def-leader
  "e" 'sk:narrow-or-widen)
