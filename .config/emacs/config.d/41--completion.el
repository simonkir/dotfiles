;;; -*- lexical-binding: t; -*-

; * general settings
; ** completion styles
(setq completion-styles '(orderless basic partial-completion))
(setq completion-auto-help 'lazy)

; ** completion-at-point-functions
;; general capfs
(add-hook 'after-change-major-mode-hook
          #' (lambda ()
               (add-to-list 'completion-at-point-functions #'cape-file 'append)
               (add-to-list 'completion-at-point-functions #'cape-dabbrev 'append)))

;; lang-specific capfs
(add-hook 'org-mode-hook #'(lambda () (setq completion-at-point-functions '())))

; ** misc
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

; * backends
; ** cape
(use-package cape
  :demand t
  :config
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-buster))

; ** dabbrev
(use-package dabbrev
  :demand t
  :config
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode))

; ** orderless
(use-package orderless
  :demand t)

; * frontend (corfu)
(use-package corfu
  :demand t
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-quit-no-match nil)
  (setq corfu-preselect 'prompt)
  (setq corfu-cycle t)

  (general-def corfu-map
    "C-SPC"  'corfu-insert-separator
    "<tab>" 'corfu-next
    "<backtab>" 'corfu-previous)

  (global-corfu-mode))

; * backtab key
(defun sk:complete-at-point-undo ()
  "determines and performs desired action on backtab input

when in org-table: go to previous field
else: do nothing"
  (interactive)
  (cond
   ;; org-mode table cell navigation
   ((and (derived-mode-p 'org-mode)
         (member (nth 0 (org-element-at-point)) #'(table-row table)))
    (org-table-previous-field))

   ;; decrease indentation
   (t nil)))

(general-def meow-insert-state-keymap
  "<backtab>" 'sk:complete-at-point-undo)

; * tab key
(defun sk:complete-at-point ()
  "determines and performs desired action on tab input

when in org-table: go to next field
when snippet expandable: expand corresponding snippet
when writing in org-/latex-mode: complete using 'cdlatex-tab'
when writing in other modes: complete using 'completion-at-point'
else: indent"
  (interactive)
  (cond
   ;; org-table tabbing
   ;; before snippet to avoid unwanted interferences
   ((and (derived-mode-p 'org-mode)
         (member (nth 0 (org-element-at-point)) #'(table-row table)))
    (org-table-next-field))

   ;; snippet exapnsion
   ((when yas-minor-mode
      (let ((yas-fallback-behavior 'return-nil))
        (when (yas-expand)
          (run-hooks 'post-self-insert-hook)))))

   ;; completion (depending on major-mode)
   ((string-match-p "[[:alnum:]}]" (char-to-string (preceding-char)))
    (cond
     ((and (derived-mode-p 'latex-mode)
           (not (derived-mode-p 'prog-mode))
           (texmathp))
      (cdlatex-tab))
     (t (completion-at-point))))

   ;; indentation
   (t (indent-for-tab-command))))

(general-def meow-insert-state-keymap
  "<tab>"     'sk:complete-at-point)
