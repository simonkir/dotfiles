;;; -*- lexical-binding: t; -*-

; * font switching
; ** default fonts
(set-face-attribute 'default nil :family "Monospace" :height 100)
(set-face-attribute 'variable-pitch nil :family "Noto Serif" :height 100)

(setq sk:fonts-fixed-pitch '("Monospace" "Roboto Mono" "Source Code Pro"))
(setq sk:fonts-variable-pitch '("Noto Serif" "C059" "Georgia" "Ubuntu" "Noto Sans"))

; ** switching defuns
(defun sk:set-face-fixed ()
  "set and apply 'default' font face"
  (interactive)
  (let* ((new-face (completing-read "new fixed-pitch face: " sk:fonts-fixed-pitch nil nil))
         (height (if (string= new-face "Inconsolata")
                     (setq height 110)
                   (setq height 100))))
    (set-face-attribute 'default nil :family new-face :height height)))

(defun sk:set-face-variable ()
  "set and apply 'variable' font face"
  (interactive)
  (let ((new-face (completing-read "new variable-pitch face: " sk:fonts-variable-pitch nil nil))
        (height 100))
    (set-face-attribute 'variable-pitch nil :family new-face :height height))
  (when mixed-pitch-mode
    (mixed-pitch-mode 'toggle)
    (mixed-pitch-mode 'toggle)))

; ** keybinds
(general-def-leader
  "d f" 'sk:set-face-fixed
  "d v" 'sk:set-face-variable)

; * mixed-pitch mode
(use-package mixed-pitch
  :hook ((org-mode TeX-mode text-mode) . mixed-pitch-mode)
  :general (general-def-leader "d m" 'mixed-pitch-mode)
  :config
  (setq mixed-pitch-variable-pitch-cursor nil)
  (setq mixed-pitch-set-height t)) ;; keep filled cursor

; * prettification
; ** org-mode definitions
(defun sk:prettify-symbols-org-mode ()
  "add org-specific prettifications to 'prettify-symbols-alist'"
  ;; environments
  (add-to-list 'prettify-symbols-alist '("#+begin_latex latex" . (?\s (Bc . Bc) ?⮟)))
  (add-to-list 'prettify-symbols-alist '("#+end_latex" . (?\s (Bc . Bc) ?⮝)))
  (add-to-list 'prettify-symbols-alist '("#+begin_src" . (?\s (Bc . Bc) ?»)))
  (add-to-list 'prettify-symbols-alist '("#+end_src" . (?\s (Bc . Bc) ?«)))
  (add-to-list 'prettify-symbols-alist '("#+begin_quote" . (?\s (bc . bc) ?“)))
  (add-to-list 'prettify-symbols-alist '("#+end_quote" . (?\s (bc . bc) ?”)))

  ;; misc
  ;;(add-to-list 'prettify-symbols-alist '("#+attr_latex" . (?\s (Bc . Bc) ?l (Bc . Bc) ?_)))
  ;;(add-to-list 'prettify-symbols-alist '("#+attr_org" . (?\s (Bc . Bc) ?o (Bc . Bc) ?_)))
  (add-to-list 'prettify-symbols-alist '("#+author" . (?\s (Bc . Bc) ?𝘼)))
  ;;(add-to-list 'prettify-symbols-alist '("#+caption" . (?\s (Bc . Bc) ?»)))
  (add-to-list 'prettify-symbols-alist '("#+date" . (?\s (Bc . Bc) ?𝘿)))
  ;;(add-to-list 'prettify-symbols-alist '("#+latex_class" . (?\s (Bc . Bc) ?🄻)))
  ;;(add-to-list 'prettify-symbols-alist '("#+latex_class_options" . (?\s (Bc . Bc) ?🄻)))
  ;;(add-to-list 'prettify-symbols-alist '("#+latex_header" . (?\s (Bc . Bc) ?🅻)))
  ;;(add-to-list 'prettify-symbols-alist '("#+options" . (?\s (Bc . Bc) ?☸)))
  (add-to-list 'prettify-symbols-alist '("#+subtitle" . (?\s (Bc . Bc) ?𝙩)))
  (add-to-list 'prettify-symbols-alist '("#+title" . (?\s (Bc . Bc) ?𝙏))))

; ** org- & latex-mode definitions
(defun sk:prettify-symbols-org-LaTeX-mode ()
  "add latex-specific prettifications to 'prettify-symbols-alist'

also displayed in org documents"
  ;; aligned operators
  (add-to-list 'prettify-symbols-alist '("&=&" . "="))
  (add-to-list 'prettify-symbols-alist '("&<&" . "<"))
  (add-to-list 'prettify-symbols-alist '("&>&" . ">"))
  (add-to-list 'prettify-symbols-alist '("&|" . "|"))
  (add-to-list 'prettify-symbols-alist '("\\\\" . (?\s (Bc . Bc) ?⏎)))
  (add-to-list 'prettify-symbols-alist '("&\\approx&" . "≈"))
  (add-to-list 'prettify-symbols-alist '("&\\BAR&" . "‖"))
  (add-to-list 'prettify-symbols-alist '("&\\neq&" . "≠"))
  (add-to-list 'prettify-symbols-alist '("&\\overset{!}{=}&" . (?= (tc . bc) ?!)))
  (add-to-list 'prettify-symbols-alist '("&\\geq&" . "≥"))
  (add-to-list 'prettify-symbols-alist '("&\\leq&" . "≤"))
  (add-to-list 'prettify-symbols-alist '("&\\leftrightarrow&" . (?\s (Bc . Bc) ?↔)))
  (add-to-list 'prettify-symbols-alist '("&\\Leftrightarrow&" . (?\s (Bc . Bc) ?⇔)))
  (add-to-list 'prettify-symbols-alist '("&\\rightleftharpoons&" . (?\s (cl . bl) ?⟶ (bl . cl) ?⟵)))
  (add-to-list 'prettify-symbols-alist '("&\\longrightarrow&" . "⟶"))
  (add-to-list 'prettify-symbols-alist '("&\\longleftarrow&" . "⟵"))

  ;; misc
  (add-to-list 'prettify-symbols-alist '("\\bot" . (?\s (Bc . Bc) ?⊥)))
  (add-to-list 'prettify-symbols-alist '("\\degree" . "°"))
  (add-to-list 'prettify-symbols-alist '("\\ldots" . "…"))
  (add-to-list 'prettify-symbols-alist '("\\lightning" . (?\s (Bc . Bc) ?↯)))
  (add-to-list 'prettify-symbols-alist '("\\longleftarrow" . "⟵"))
  (add-to-list 'prettify-symbols-alist '("\\longrightarrow" . "⟶"))
  (add-to-list 'prettify-symbols-alist '("\\mapsto" . (?\s (Bc . Bc) ?↦)))
  (add-to-list 'prettify-symbols-alist '("\\mid" . (?\s (Bc . Bc) ?∣)))
  (add-to-list 'prettify-symbols-alist '("\\nmid" . (?\s (Bc . Bc) ?∤)))
  (add-to-list 'prettify-symbols-alist '("\\pause" . "⏸"))
  (add-to-list 'prettify-symbols-alist '("\\pm" . "±"))
  (add-to-list 'prettify-symbols-alist '("\\rightleftharpoons" . (?\s (cl . bl) ?⟶ (bl . cl) ?⟵)))
  (add-to-list 'prettify-symbols-alist '("\\subseteq" . (?\s (Bc . Bc) ?⊆)))
  (add-to-list 'prettify-symbols-alist '("\\supseteq" . (?\s (Bc . Bc) ?⊇)))
  (add-to-list 'prettify-symbols-alist '("\\top" . (?\s (Bc . Bc) ?⊤)))
  (add-to-list 'prettify-symbols-alist '("\\vartheta" . "ϑ"))

  ;; braces
  (add-to-list 'prettify-symbols-alist '("\\left(" . (?\s (Bc . Bc) ?⸨)))
  (add-to-list 'prettify-symbols-alist '("\\right)" . (?\s (Bc . Bc) ?⸩)))
  (add-to-list 'prettify-symbols-alist '("\\left[" . "⟦"))
  (add-to-list 'prettify-symbols-alist '("\\right]" . "⟧"))
  (add-to-list 'prettify-symbols-alist '("\\left\\{" . "⦃"))
  (add-to-list 'prettify-symbols-alist '("\\right\\}" . "⦄"))
  (add-to-list 'prettify-symbols-alist '("\\left|" . "‖"))
  (add-to-list 'prettify-symbols-alist '("\\right|" . "‖"))
  (add-to-list 'prettify-symbols-alist '("\\left\\|" . (?‖ (Br . Bl) ?‖)))
  (add-to-list 'prettify-symbols-alist '("\\right\\|" . (?‖ (Br . Bl) ?‖)))

  ;; double-struck letters
  (add-to-list 'prettify-symbols-alist '("\\mathbb{C}" . (?\s (Bc . Bc) ?ℂ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{D}" . (?\s (Bc . Bc) ?𝔻)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{G}" . (?\s (Bc . Bc) ?𝔾)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{K}" . (?\s (Bc . Bc) ?𝕂)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{L}" . (?\s (Bc . Bc) ?𝕃)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{N}" . (?\s (Bc . Bc) ?ℕ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{P}" . (?\s (Bc . Bc) ?ℙ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{Q}" . (?\s (Bc . Bc) ?ℚ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{R}" . (?\s (Bc . Bc) ?ℝ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{W}" . (?\s (Bc . Bc) ?𝕎)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{Z}" . (?\s (Bc . Bc) ?ℤ))))

; ** latex-mode definitions
(defun sk:prettify-symbols-LaTeX-mode ()
  "add latex-specific prettifications to 'prettify-symbols-alist'

not displayed in org documents unless in #+begin_latex environment"
  (add-to-list 'prettify-symbols-alist '("&" . "·"))
  (add-to-list 'prettify-symbols-alist '("&&" . (?· (Br . Bl) ?·))))

; ** hooks & activation
(add-hook 'org-mode-hook 'sk:prettify-symbols-org-mode)
(add-hook 'org-mode-hook 'sk:prettify-symbols-org-LaTeX-mode)
(add-hook 'LaTeX-mode-hook 'sk:prettify-symbols-LaTeX-mode)
(add-hook 'LaTeX-mode-hook 'sk:prettify-symbols-org-LaTeX-mode)

(global-prettify-symbols-mode)

; ** keybinds
(general-def-leader
  "t p" 'prettify-symbols-mode)

