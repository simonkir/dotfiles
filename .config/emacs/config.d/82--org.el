;;; -*- lexical-binding: t; -*-

; * org
; ** init section
(use-package org
  :general
  (general-def-leader
    "r n" 'sk:org-agenda-dashboard
    "r N" 'org-agenda
    "r c" 'org-capture)

  :config
; ** general org
; *** visuals
  (setq org-num-max-level 3)
  (setq org-startup-folded t)
  (setq org-return-follows-link t)

  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers t)
  (setq org-fontify-whole-heading-line t)
  (setq org-fontify-done-headline t)
  (setq org-fontify-quote-and-verse-blocks t)

  (setq org-emphasis-alist
        '(("*" bold)
          ("/" italic)
          ("_" underline)
          ("=" org-verbatim verbatim)
          ("~" org-code verbatim)))

  (defun sk:org-toggle-emphasis-markers ()
    "toggle display of emphasis markers"
    (interactive)
    (org-toggle-link-display)
    (if org-hide-emphasis-markers
        (setq org-hide-emphasis-markers nil)
      (setq org-hide-emphasis-markers t))
    (org-restart-font-lock)
    (message "org: toggled display of emphasis markers"))

  (general-def org-mode-map
    "C-c C-x C-h" 'org-toggle-pretty-entities
    "C-c C-x H" 'sk:org-toggle-emphasis-markers)

  (add-hook 'org-mode-hook #'org-num-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'org-toggle-pretty-entities)

; *** editing
; **** sk:org-return
  ;; inspired from github.com/alphapapa/unpackaged.el
  (defun sk:org-return (&optional default)
    "custom `org-return'. respects lists and tables like one would expect in a normal dwim editor

with prefix arg, call `org-return'"
    (interactive "P")
    (if default
        (org-return)
      (cond
       ;; tables
       ((org-at-table-p)
        (cond ((save-excursion
                 (beginning-of-line)
                 ;; See `org-table-next-field'.
                 (cl-loop with end = (line-end-position)
                          for cell = (org-element-table-cell-parser)
                          always (equal (org-element-property :contents-begin cell)
                                        (org-element-property :contents-end cell))
                          while (re-search-forward "|" end t)))
               ;; Empty row: end the table.
               (delete-region (line-beginning-position) (line-end-position))
               (org-return))
              (t
               ;; Non-empty row: call `org-return'.
               (org-return))))

       ;; lists (incl. checkboxes)
       ((org-in-item-p)
        (if (save-excursion
              (beginning-of-line)
              (org-element-property :contents-begin (org-element-context)))
            ;; add new item
            (org-insert-item (org-at-item-checkbox-p))
          ;; empty item, finish list
          (delete-region (line-beginning-position) (line-end-position))
          (org-return)))

       ;; fallback
       (t
        (org-return 'indent)))))

; **** keybinds
  (general-def org-mode-map
    "C-c C-_" #'(lambda () (interactive) (org-cycle-list-bullet 'previous))
    "C-#" #'(lambda () (interactive) (insert "#"))

    "C-c C-," 'org-priority
    "C-c ," 'org-insert-structure-template

    "RET" 'sk:org-return
    "M-RET" 'org-ctrl-c-ctrl-c
    "C-M-<return>" 'org-return

    ;; disable these, use own outline keybinds instead
    ;; see 31--buffer-local.el
    "C-c C-n" nil
    "C-c C-p" nil
    "C-c C-f" nil
    "C-c C-b" nil
    "C-c C-u" nil

    "M-h" 'org-metaleft
    "M-H" 'org-shiftmetaleft
    "M-j" 'org-metadown
    "M-J" 'org-shiftmetadown
    "M-k" 'org-metaup
    "M-K" 'org-shiftmetaup
    "M-l" 'org-metaright
    "M-L" 'org-shiftmetaright)

; *** narrowing
  ;; see `sk:narrow-or-widen' for regular src- / table-editing

  (setq org-edit-src-content-indentation 0)
  (setq org-src-window-setup 'current-window)

  (defun sk:leader-E ()
    "determine and perform desired action on <leader>-E input"
    (interactive)
    (when (derived-mode-p 'org-mode)
      (let ((org-src-window-setup 'other-frame))
        (org-edit-special))))

  (general-def-leader
    "E" 'sk:leader-E)

; *** lists
  (setq org-blank-before-new-entry
        '((heading . t)
          (plain-list-item . nil)))

  (setq org-list-demote-modify-bullet
        '(("+" . "-")
          ("-" . "+")
          ("1." . "-")
          ("1)" . "-")))

; *** images
  (setq org-image-actual-width nil)

  (defun sk:org-toggle-inline-images ()
    "toggle image previews in the region, if it is active, and the next image after point otherwise"
    (interactive)
    (let* ((beg (if (region-active-p)
                    (region-beginning)
                  (line-beginning-position)))
           (end (if (region-active-p)
                    (region-end)
                  (save-excursion
                    (beginning-of-line)
                    (re-search-forward "\\]\\]")
                    (line-end-position))))
           (overlays-in-region (seq-intersection (overlays-in beg end) org-inline-image-overlays)))
      (if overlays-in-region
          (mapc (lambda (ov)
                  (delete-overlay ov)
                  (setq org-inline-image-overlays (delete ov org-inline-image-overlays)))
                overlays-in-region)
        (org-display-inline-images t nil beg end)))
    (message "org-mode: toggled image preview"))

  (general-def org-mode-map
    "C-c C-x C-v" 'sk:org-toggle-inline-images
    "C-c C-x V" 'org-toggle-inline-images
    "C-c C-x M-v" 'org-redisplay-inline-images)

; *** latex
; **** general settings
  (setq org-highlight-latex-and-related '(native))

  (setq org-latex-packages-alist
        '(("" "IEEEtrantools" t)
          ("" "gensymb" t)))

  (add-hook 'org-mode-hook #'(lambda ()
                               (modify-syntax-entry ?< "@") ;; prevent < and > from being
                               (modify-syntax-entry ?> "@") ;; interpreted as delimiters
                               (modify-syntax-entry ?\\ "w")
                               (modify-syntax-entry ?^ "_") ;; allows prettification of super-/subscripts
                               (modify-syntax-entry ?$ "$")))

; **** export settings
  (setq org-latex-compiler "lualatex")
  (setq org-latex-pdf-process '("latexmk -f -pdflua -interaction=nonstopmode -shell-escape -output-directory=%o %f"))

  (setq org-latex-classes
        '(("article" "\\documentclass{article}"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
          ("report" "\\documentclass{report}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("report-nopart" "\\documentclass{report}"
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("book" "\\documentclass{book}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("scrlttr2" "\\documentclass{scrlttr2}")
          ("moderncv" "\\documentclass{moderncv}"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}"))
          ("fmcmppk" "\\documentclass{fmcmppk}"
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

; **** latex preview
  (defvar sk:org-preview-latex-scale 1.5 "org latex preview scale factor")
  (plist-put org-format-latex-options :scale sk:org-preview-latex-scale)

  (defun sk:org-preview-latex-scale-set (new-scale)
    "interactively reads a new latex preview scale"
    (interactive "nnew preview scale: ")
    (setq sk:org-preview-latex-scale new-scale)
    (plist-put org-format-latex-options :scale sk:org-preview-latex-scale)
    (message "latex preview scale set to %s" sk:org-preview-latex-scale))

  (defun sk:org-latex-preview-at-point ()
    "toggles preview of latex-code at point"
    (interactive)
    (if (or (org-in-block-p '("latex"))
            (org-in-regexp "\$.*\$"))
        (org-latex-preview)
      (message "not inside latex environment")))

  (general-def org-mode-map
    "C-c C-x L" 'sk:org-preview-latex-scale-set)

; ** agenda
; *** general settings
  (setq org-directory (expand-file-name (concat user-emacs-directory "org-dir")))
  (setq org-agenda-files `(,org-directory))

  (setq org-todo-keywords '((sequence "PREP" "TODO" "POST" "|" "DONE")))

  (setq vc-follow-symlinks t)
  (setq calendar-week-start-day 1)
  (setq org-agenda-window-setup 'current-window)

; *** agenda views
  (setq org-agenda-custom-commands
        '(("n" "Dashboard"
           ((agenda "" ((org-agenda-overriding-header "Agenda")
                        (org-agenda-span 'day)
                        (org-deadline-warning-days 2)
                        (org-agenda-skip-scheduled-if-done t)
                        (org-agenda-skip-deadline-if-done t)
                        (org-agenda-use-time-grid nil)))
            (agenda "" ((org-agenda-overriding-header "Calendar")
                        (org-agenda-span 'week)
                        (org-agenda-start-on-weekday nil)
                        (org-agenda-start-day "+1d")
                        (org-scheduled-past-days 0)
                        (org-deadline-past-days 0)
                        (org-deadline-warning-days 0)
                        (org-agenda-skip-scheduled-if-done t)
                        (org-agenda-skip-deadline-if-done t)
                        (org-agenda-use-time-grid nil)))
            (todo "" ((org-agenda-overriding-header "Unplanned Tasks")
                      (org-agenda-todo-ignore-with-date t)))
            (todo "DONE" ((org-agenda-overriding-header "Done Tasks")))))))

  (setq org-agenda-block-separator "")
  (setq org-agenda-scheduled-leaders '("Scheduled:  " "Sch. %2dd.: "))
  (setq org-agenda-deadline-leaders '("Deadlined:  " "In %2dd.:   " "Past %2dd.: "))

  (setq org-agenda-sorting-strategy
        '((agenda category-up time-up priority-down alpha-up)
          (todo category-up priority-down alpha-up)
          (tags category-up priority-down alpha-up)
          (search alpha-up)))

  (setq org-agenda-prefix-format
   '((agenda . "%i %-7:c%?-12t %s")
     (todo . "%i %-7:c")
     (tags . "%i %-7:c")
     (search . "%i %-7:c")))

  (defun sk:org-agenda-dashboard ()
    (interactive)
    (org-agenda nil "n"))

; *** keybinds
  (general-def org-agenda-mode-map
    "D" 'org-agenda-goto-date
    "g" 'org-agenda-redo
    "M" 'org-agenda-month-view
    "n" 'org-agenda-next-date-line
    "p" 'org-agenda-previous-date-line
    "P" 'org-agenda-set-property
    "q" 'org-agenda-exit
    "Q" 'org-agenda-quit
    "r" 'org-agenda-redo-all
    "W" 'org-agenda-fortnight-view)

; *** capture
  (setq org-bookmark-names-plist nil)
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 1))))
  (setq org-default-notes-file (expand-file-name (concat user-emacs-directory "org-dir/notes.org")))

  (setq org-capture-templates
        '(("c" "generic TODO entry" entry (file "") "* TODO %?\n" :empty-lines 1)
          ("v" "generic PREP entry" entry (file "") "* PREP %?\n" :empty-lines 1)))

  (general-def org-capture-mode-map
    "C-c C-c" nil)

; ** org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((gnuplot . t)))
   ;;'((jupyter . t)))

  ;;(add-hook 'org-babel-after-execute-hook #'sk:org-toggle-inline-images-after-babel-run)

  (setq org-confirm-babel-evaluate nil)

  (defun sk:org-babel-kill-session-at-point ()
    (interactive)
    (kill-buffer (concat "*" (concat (nth 0 (org-babel-get-src-block-info)) "*"))))

  (defun sk:org-babel-eval-with-new-session ()
    (interactive)
    (sk:org-babel-kill-session-at-point)
    (org-ctrl-c-ctrl-c)))

; * org-superstar
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("❃" "★" "✦" "☆" "✧" "•"))
  (setq org-superstar-item-bullet-alist '((42 . "•") (43 . (?\s (Bc . Bc) ?→)) (45 . "–"))))
