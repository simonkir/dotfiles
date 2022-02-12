;;; -*- lexical-binding: t; -*-



(use-package org
  :defer t
  :config

  ; content ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq org-startup-folded     t)
  (setq org-hide-leading-stars t)
  (setq org-num-max-level      4)

  (add-hook 'org-mode-hook 'org-num-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)



  ; editing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . nil)))
  (setq org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+")
          ("1." . "-") ("1)" . "-")))

  ;;(add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'dubcaps-mode)
  (add-to-list 'org-latex-packages-alist '("" "IEEEtrantools" t))



  ; visual effects ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq org-hide-emphasis-markers          t)
  (setq org-fontify-whole-heading-line     t)
  (setq org-fontify-done-headline          t)
  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-image-actual-width             nil)

  (add-hook 'org-mode-hook 'org-toggle-pretty-entities)



  ; org-babel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((gnuplot . t)))
   ;;'((jupyter . t)))

  (add-hook 'org-babel-after-execute-hook 'sk:org-toggle-inline-images-after-babel-run)

  (setq org-src-window-setup 'current-window) ;; don't spread across two windows
  (setq org-confirm-babel-evaluate nil)

  (defun sk:org-edit-special-current-window ()
	(interactive)
	(setq org-src-window-setup 'current-window)
	(org-edit-special))

  (defun sk:org-edit-special-new-window ()
	(interactive)
	(setq org-src-window-setup 'split-window-right)
	(org-edit-special))



  ; mappings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (general-def 'normal org-mode-map :prefix "SPC SPC"
    "-" 'org-ctrl-c-minus ;; separator line in table
    "b" 'org-ctrl-c-minus ;; cycle list bullet style

    "TAB"       'org-table-toggle-column-width
    "<backtab>" '(lambda () (interactive) (org-table-toggle-column-width '(4)))
    "c"         '(lambda () (interactive) (org-ctrl-c-ctrl-c             '(4)))

    "n" 'org-num-mode
    "h" 'org-toggle-heading
    "t" 'org-todo

    "f" 'org-table-eval-formula
    "F" '(lambda () (interactive) (org-table-eval-formula '(4)))

    "e" 'org-babel-execute-buffer)

  (general-def 'normal org-mode-map
	;; – toggle checkboxes
	;; – renumber ordered list
	;; – realign table
	;; – execute dynamic block
	;; – remove highlights
	;; – insert tags
    "RET" 'org-ctrl-c-ctrl-c
    "SPC e" 'sk:org-edit-special-current-window
    "SPC E" 'sk:org-edit-special-new-window)

  (general-def 'insert 'org-mode-map
	"C-#" '(lambda () (interactive) (insert "#")))

  (general-def 'normal
    "SPC e" 'org-edit-src-exit)



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



  (general-def 'normal org-mode-map :prefix "SPC SPC l"
    "l" 'sk:org-latex-preview-at-point
    "L" '(lambda () (interactive) (org-latex-preview '(4)))  ;; clear all latex previews
    "b" '(lambda () (interactive) (org-latex-preview '(16))) ;; preview whole buffer
    "B" '(lambda () (interactive) (org-latex-preview '(64))) ;; clear whole buffer
    "+" 'sk:org-preview-latex-scale-increase
    "-" 'sk:org-preview-latex-scale-decrease
    "0" 'sk:org-preview-latex-scale-reset
    "s" 'sk:org-preview-latex-scale-set)



  ; image preview ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun sk:org-toggle-inline-images-in-region (beg end)
	"note: lines with multiple images might cause unexpected behaviour"
	(if (-intersection (overlays-in beg end) org-inline-image-overlays)
        (mapc (lambda (ov)
            (when (member ov org-inline-image-overlays)
              (delete-overlay ov)
              (setq org-inline-image-overlays (delete ov org-inline-image-overlays))))
          (overlays-in beg end))
	  (org-display-inline-images t nil beg end)))

  (defun sk:org-toggle-inline-images-after-babel-run ()
	(interactive)
	(let ((initial-point-position (point)))
	  (progn
		(re-search-forward (rx "#+end_src"))
		(let ((ln-end-src (line-number-at-pos)))
		  (progn
			(re-search-forward (rx "#+RESULTS:"))
			(let ((ln-results (line-number-at-pos)))
			  (when (eq 2 (- ln-results ln-end-src))
				(forward-line)
				(sk:org-toggle-inline-images-at-point))))
		(goto-char initial-point-position)))))

  (defun sk:org-toggle-inline-images-at-point ()
	(interactive)
    (sk:org-toggle-inline-images-in-region (line-beginning-position) (line-end-position)))



  (general-def 'normal org-mode-map :prefix "SPC SPC i"
    "i" 'sk:org-toggle-inline-images-at-point
	"b" 'org-toggle-inline-images
	"B" 'org-remove-inline-images
    "r" 'org-redisplay-inline-images))



; export settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ox
  :after org
  :general ('normal org-mode-map :prefix "SPC SPC"
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



; misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("❃" "★" "✦" "•" "☆" "✧"))
  (setq org-superstar-item-bullet-alist '((42 . "•") (43 . (?\s (Bc . Bc) ?→)) (45 . "–"))))



(use-package evil-org
  :ensure t
  :hook (org-mode . evil-org-mode))
