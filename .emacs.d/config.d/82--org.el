;;; -*- lexical-binding: t; -*-



(use-package org
  :config

  ; content ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq org-num-max-level 3)
  (setq org-return-follows-link t)
  (setq org-image-actual-width nil)

  (setq org-startup-folded t)
  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers t)

  (setq org-fontify-whole-heading-line t)
  (setq org-fontify-done-headline t)
  (setq org-fontify-quote-and-verse-blocks t)

  (add-hook 'org-mode-hook '(lambda () (modify-syntax-entry ?< "@")))
  (add-hook 'org-mode-hook '(lambda () (modify-syntax-entry ?> "@")))

  (add-hook 'org-mode-hook 'org-num-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'org-toggle-pretty-entities)



  ; editing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . nil)))
  (setq org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+")
          ("1." . "-") ("1)" . "-")))

  (add-hook 'org-mode-hook 'sk:autocorrect-mode)
  (add-to-list 'org-latex-packages-alist '("" "IEEEtrantools" t))



  ; latex preview ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq sk:org-preview-latex-scale-increment 0.2)
  (setq sk:org-preview-latex-scale 1.5)
  (setq sk:org-preview-latex-default-scale sk:org-preview-latex-scale)
  (plist-put org-format-latex-options :scale sk:org-preview-latex-default-scale)

  (defun sk:org-preview-latex-scale--aftermath ()
    (plist-put org-format-latex-options :scale sk:org-preview-latex-scale)
    (message "%s" (concat "latex preview scale set to " (number-to-string sk:org-preview-latex-scale))))

  (defun sk:org-preview-latex-scale-increase ()
    (interactive)
    (setq sk:org-preview-latex-scale (+ sk:org-preview-latex-scale sk:org-preview-latex-scale-increment))
    (sk:org-preview-latex-scale--aftermath))

  (defun sk:org-preview-latex-scale-decrease ()
    (interactive)
    (setq sk:org-preview-latex-scale (- sk:org-preview-latex-scale sk:org-preview-latex-scale-increment))
    (sk:org-preview-latex-scale--aftermath))

  (defun sk:org-preview-latex-scale-set (new-scale)
    (interactive "nnew preview scale: ")
    (setq sk:org-preview-latex-scale new-scale)
    (sk:org-preview-latex-scale--aftermath))

  (defun sk:org-preview-latex-scale-reset ()
    (interactive)
    (setq sk:org-preview-latex-scale sk:org-preview-latex-default-scale)
    (sk:org-preview-latex-scale--aftermath))

  (defun sk:org-latex-preview-at-point ()
    (interactive)
    (if (or (org-in-block-p '("latex"))
            (org-in-regexp "\$.*\$"))
        (org-latex-preview)
      (message "not inside latex environment")))



  (general-def-localleader org-mode-map
    "l l" 'sk:org-latex-preview-at-point
    "l L" '(lambda () (interactive) (org-latex-preview '(4)))  ;; clear all latex previews
    "l b" '(lambda () (interactive) (org-latex-preview '(16))) ;; preview whole buffer
    "l B" '(lambda () (interactive) (org-latex-preview '(64))) ;; clear whole buffer
    "l +" 'sk:org-preview-latex-scale-increase
    "l -" 'sk:org-preview-latex-scale-decrease
    "l 0" 'sk:org-preview-latex-scale-reset
    "l s" 'sk:org-preview-latex-scale-set)



  ; image preview ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun sk:org-toggle-inline-images (beg end)
    "toggle image previews between `beg' and `end'."
    (let ((overlays-in-region (seq-intersection (overlays-in beg end) org-inline-image-overlays)))
      (if overlays-in-region
          (mapc (lambda (ov)
              (delete-overlay ov)
              (setq org-inline-image-overlays (delete ov org-inline-image-overlays)))
            overlays-in-region)
        (org-display-inline-images t nil beg end))))

  (defun sk:org-toggle-inline-images-after-babel-run ()
    "activates image preview for babel results

the function looks for an `#+end_src', followed by an empty line and a `#+RESULTS:', which is the default syntax for image (link) results. otherwise, no image will be previewed due to the risk of previewing something unintended."
    (interactive)
    (save-excursion
      (re-search-forward "\\[\\[")
      (sk:org-toggle-inline-images-at-point)))

  (defun sk:org-toggle-inline-images-at-point ()
    "toggles image previews in the current line"
    (interactive)
    (sk:org-toggle-inline-images (line-beginning-position) (line-end-position)))

  (defun sk:org-toggle-inline-images-in-region ()
    (interactive)
    (sk:org-toggle-inline-images (region-beginning) (region-end)))



  (general-def-localleader org-mode-map
    "i i" 'sk:org-toggle-inline-images-at-point
    "i b" 'org-toggle-inline-images
    "i B" 'org-remove-inline-images
    "i r" 'org-redisplay-inline-images)

  ;;(general-def 'normal org-mode-map "SPC SPC i i" 'sk:org-toggle-inline-images-at-point)
  ;;(general-def 'visual org-mode-map "SPC SPC i i" 'sk:org-toggle-inline-images-in-region)



  ; org-babel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((gnuplot . t)))
   ;;'((jupyter . t)))

  (add-hook 'org-babel-after-execute-hook 'sk:org-toggle-inline-images-after-babel-run)

  (setq org-confirm-babel-evaluate nil)
  (setq org-edit-src-content-indentation 0)

  (defun sk:leader-e ()
    (interactive)
    (if (derived-mode-p 'org-mode)
        (let ((org-src-window-setup 'current-window))
          (org-edit-special))
      (org-edit-src-exit)))

  (defun sk:leader-E ()
    (interactive)
    (when (derived-mode-p 'org-mode)
      (let ((org-src-window-setup 'split-window-right))
        (org-edit-special))))

  (defun sk:org-babel-kill-session-at-point ()
    (interactive)
    (kill-buffer (concat "*" (concat (nth 0 (org-babel-get-src-block-info)) "*"))))

  (defun sk:org-babel-eval-with-new-session ()
    (interactive)
    (sk:org-babel-kill-session-at-point)
    (org-ctrl-c-ctrl-c))



  (general-def-leader
    "e" 'sk:leader-e
    "E" 'sk:leader-E)
  
  (general-def-localleader org-mode-map
    "k"   'sk:org-babel-kill-session-at-point
    "RET" 'sk:org-babel-eval-with-new-session)



  ; mappings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun sk:org-return ()
    (interactive)
    (cond
     ((org-at-table-p) (org-table-insert-row '(4)))
     ((org-in-item-p)
      (if (save-excursion
            (beginning-of-line)
            (org-element-property :contents-begin (org-element-context)))
          (org-insert-item (org-at-item-checkbox-p))
        (delete-region (line-beginning-position) (line-end-position))
        (org-return)))
     (t (org-return))))

  
  
  (general-def-localleader org-mode-map
    "-" 'org-ctrl-c-minus ;; separator line in table
    "b" 'org-cycle-list-bullet
    "B" '(lambda () (interactive) (org-cycle-list-bullet 'previous))
    "c" '(lambda () (interactive) (org-ctrl-c-ctrl-c '(4)))
    "n" 'org-num-mode
    "h" 'org-toggle-heading
    "t" 'org-todo)

  ;;(general-def meow-normal-state-keymap :predicate '(derived-mode-p 'org-mode)
  ;;  "RET" 'org-ctrl-c-ctrl-c
  ;;  "g j" 'org-forward-element
  ;;  "g k" 'org-backward-element
  ;;  "g J" 'org-next-visible-heading
  ;;  "g K" 'org-previous-visible-heading)

  (general-def org-mode-map
    "RET" 'sk:org-return
    "M-h" 'org-metaleft
    "M-H" 'org-shiftmetaleft
    "M-j" 'org-metadown
    "M-J" 'org-shiftmetadown
    "M-k" 'org-metaup
    "M-K" 'org-shiftmetaup
    "M-l" 'org-metaright
    "M-L" 'org-shiftmetaright)

  ;; override org default tab key behaviour
  (general-def org-mode-map
    "<backtab>" 'sk:insert-backtab-key
    "C-#" '(lambda () (interactive) (insert "#"))))





; export settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ox
  :after org
  :general (general-def-localleader org-mode-map
    "X" 'org-export-dispatch
    "x" '(lambda () (interactive) (org-export-dispatch '(4)))))



(use-package ox-latex
  :after ox
  :config
  (add-to-list 'org-latex-classes '("report-nopart" "\\documentclass[11pt]{report}"
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes '("scrlttr2" "\\documentclass[12pt,foldmarks=false,fromalign=right]{scrlttr2}"
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))



(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("❃" "★" "✦" "☆" "✧" "•"))
  (setq org-superstar-item-bullet-alist '((42 . "•") (43 . (?\s (Bc . Bc) ?→)) (45 . "–"))))



;;(use-package evil-org
;;  :hook (org-mode . evil-org-mode))
