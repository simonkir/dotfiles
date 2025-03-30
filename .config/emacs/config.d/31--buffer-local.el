;;; -*- lexical-binding: t; -*-

; * general settings
(advice-add 'isearch-exit :after #'(lambda () (when isearch-forward (goto-char isearch-other-end))))

; * scrolling
(setq scroll-conservatively 101)

(setq mouse-wheel-scroll-amount '(1 ((shift) . hscroll)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(setq pixel-scroll-precision-interpolate-page t)
(setq pixel-scroll-precision-large-scroll-height 19)
(pixel-scroll-precision-mode 1)

(defun sk:scroll-line-down ()
  (interactive)
  (pixel-scroll-precision-interpolate -40 nil 1))

(defun sk:scroll-line-up ()
  (interactive)
  (pixel-scroll-precision-interpolate 40 nil 1))

(defun sk:scroll-page-down ()
  (interactive)
  (pixel-scroll-precision-interpolate (* (window-text-height nil t) -0.75) nil 1))

(defun sk:scroll-page-up ()
  (interactive)
  (pixel-scroll-precision-interpolate (* (window-text-height nil t) 0.75) nil 1))

(general-def
  "C-f" 'sk:scroll-page-down
  "C-b" 'sk:scroll-page-up
  "C-e" 'sk:scroll-line-down
  "C-y" 'sk:scroll-line-up)

;; (general-def
;;   "C-f" 'pixel-scroll-interpolate-down
;;   "C-b" 'pixel-scroll-interpolate-up
;;   "C-e" 'pixel-scroll-up
;;   "C-y" 'pixel-scroll-down)

; * avy
(use-package avy
  :general
  (general-def 'meow-normal-state-keymap
    "g" 'avy-goto-char-timer)

  :config
  (setq avy-all-windows 'all-frames))

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
    "v l" 'outline-show-branches
    ;;"v j" nil ;; reserved for consult
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
                 '(comment-block
                   example-block
                   src-block
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
