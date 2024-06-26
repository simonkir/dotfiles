;;; -*- lexical-binding: t; -*-

; * in-buffer completion
; ** cape (backend)
(use-package cape
  :demand t
  :config
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-buster))

; ** dabbrev (backend)
(use-package dabbrev
  :demand t
  :config
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode))

; ** corfu (frontend)
(use-package corfu
  :demand t
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preselect 'prompt)
  (setq corfu-cycle t)

  (general-def corfu-map
    "<tab>" 'corfu-next
    "<backtab>" 'corfu-previous)

  (global-corfu-mode))

; ** capf-setup
;; general capfs
(add-hook 'after-change-major-mode-hook
          #' (lambda ()
               (add-to-list 'completion-at-point-functions #'cape-file 'append)
               (add-to-list 'completion-at-point-functions #'cape-dabbrev 'append)))

;; lang-specific capfs
(add-hook 'org-mode-hook #'(lambda () (setq completion-at-point-functions '())))

; ** backtab key
(defun sk:complete-at-point-undo ()
  "determines and performs desired action on backtab input

when in org-table: go to previous field
else: un-expand last expansion"
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

; ** tab key
(defun sk:complete-at-point ()
  "determines and performs desired action on tab input

when in org-table: go to next field
when snippet expandable: expand corresponding snippet
when writing in org- / latex-mode: call 'cdlatex-tab'
when writing in other modes: call 'hippie-expand'
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
     ((derived-mode-p 'maxima-mode) (maxima-complete))
     (t (completion-at-point))))

   ;; indentation
   (t (indent-for-tab-command))))

(general-def meow-insert-state-keymap
  "<tab>"     'sk:complete-at-point)

; * minibuffer completion
; ** vertico
(use-package vertico
  :demand t
  :config
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)

  (setq completion-styles '(basic partial-completion substring initials flex))
  (setq completion-auto-help 'lazy)

  (setq vertico-preselect 'first)

  (general-def vertico-map
    "C-w" 'vertico-directory-delete-word
    "C-<backspace>" 'vertico-directory-delete-word
    "<backspace>" 'vertico-directory-delete-char
    "<S-return>" 'vertico-exit-input
    "<return>" 'vertico-directory-enter
    "<tab>" 'minibuffer-complete
    "C-j" 'vertico-next
    "C-k" 'vertico-previous)

  (vertico-mode)
  (vertico-indexed-mode))

; ** vertico-posframe
(use-package vertico-posframe
  :demand t
  :after vertico
  :config
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  (vertico-posframe-mode))

; ** marginalia
(use-package marginalia
  :demand t
  :config
  (general-def minibuffer-local-map "M-f" 'marginalia-cycle)
  (marginalia-mode))

