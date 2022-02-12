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

  (setq org-preview-latex-scale-increment 0.2)
  (setq org-preview-latex-scale 1.5)
  (setq org-preview-latex-default-scale org-preview-latex-scale)
  (plist-put org-format-latex-options :scale org-preview-latex-default-scale)

  (defun org-preview-latex-scale--aftermath ()
    (plist-put org-format-latex-options :scale org-preview-latex-scale)
    (message "%s" (concat "latex preview scale set to " (number-to-string org-preview-latex-scale))))

  (defun org-preview-latex-scale-increase ()
    (interactive)
    (setq org-preview-latex-scale (+ org-preview-latex-scale org-preview-latex-scale-increment))
    (org-preview-latex-scale--aftermath))

  (defun org-preview-latex-scale-decrease ()
    (interactive)
    (setq org-preview-latex-scale (- org-preview-latex-scale org-preview-latex-scale-increment))
    (org-preview-latex-scale--aftermath))

  (defun org-preview-latex-scale-set (new-scale)
    (interactive "nnew preview scale: ")
    (setq org-preview-latex-scale new-scale)
    (org-preview-latex-scale--aftermath))

  (defun org-preview-latex-scale-reset ()
    (interactive)
    (setq org-preview-latex-scale org-preview-latex-default-scale)
    (org-preview-latex-scale--aftermath))



  (general-def 'normal org-mode-map :prefix "SPC SPC l"
    "l" 'org-latex-preview
    "L" '(lambda () (interactive) (org-latex-preview '(4)))  ;; clear all latex previews
    "b" '(lambda () (interactive) (org-latex-preview '(16))) ;; preview whole buffer
    "B" '(lambda () (interactive) (org-latex-preview '(64))) ;; clear whole buffer
    "+" 'org-preview-latex-scale-increase
    "-" 'org-preview-latex-scale-decrease
    "0" 'org-preview-latex-scale-reset
    "s" 'org-preview-latex-scale-set)



  ; image preview ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; modified from https://www.reddit.com/r/orgmode/comments/hx5keh/comment/fz669re/?utm_source=share&utm_medium=web2x&context=3
  (defun org-toggle-inline-images-at-point ()
	(interactive)
  	(when-let* ((link-region (org-in-regexp org-link-bracket-re 1)))
  	  (let ((org-inline-image-overlays-old org-inline-image-overlays))
  		(save-restriction
  		  (narrow-to-region (car link-region) (cdr link-region))
  		  (if (-intersection (overlays-at (point)) org-inline-image-overlays)
  			  (mapc (lambda (ov)
  				  (when (member ov org-inline-image-overlays)
  					(delete-overlay ov)
  					(setq org-inline-image-overlays (delete ov org-inline-image-overlays))))
  				(overlays-at (point)))
  			(org-display-inline-images)))
  	(unless (equal org-inline-image-overlays org-inline-image-overlays-old) t)))) ;; if overlays did not change, the link is not inline image



  (general-def 'normal org-mode-map :prefix "SPC SPC i"
    "i" 'org-toggle-inline-images-at-point
	"b" 'org-toggle-inline-images
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
