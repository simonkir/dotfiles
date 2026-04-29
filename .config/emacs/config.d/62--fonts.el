;;; -*- lexical-binding: t; -*-

; * font switching
; ** default fonts
(defvar sk:fonts-fixed-pitch '("Fira Code" "Hack" "Liberation Mono" "Monospace") "alist of fixed pitch fonts. first entry is default.")
(defvar sk:fonts-variable-pitch '("Georgia" "C059" "P052" "Noto Serif") "alist of variable pitch fonts. first entry is default.")
(defvar sk:fixed-font-size 95 "font size of fixed pitch font")
(defvar sk:variable-font-size 105 "font size of variable pitch font")

(set-face-attribute 'default nil :family (car sk:fonts-fixed-pitch) :height sk:fixed-font-size)
(set-face-attribute 'variable-pitch nil :family (car sk:fonts-variable-pitch) :height sk:variable-font-size)

; ** switching defuns
(defun sk:set-face-fixed ()
  "set and apply 'default' font face"
  (interactive)
  (let* ((new-face (completing-read "new fixed-pitch face: " sk:fonts-fixed-pitch nil nil)))
    (set-face-attribute 'default nil :family new-face :height sk:fixed-font-size)))

(defun sk:set-face-variable ()
  "set and apply 'variable' font face"
  (interactive)
  (let ((new-face (completing-read "new variable-pitch face: " sk:fonts-variable-pitch nil nil)))
    (set-face-attribute 'variable-pitch nil :family new-face :height sk:variable-font-size))
  (when mixed-pitch-mode
    (mixed-pitch-mode 'toggle)
    (mixed-pitch-mode 'toggle)))

; ** keybinds
(general-def-leader
  "d f" 'sk:set-face-fixed
  "d v" 'sk:set-face-variable)

; * mixed-pitch mode
(use-package mixed-pitch
  :hook ((org-mode TeX-mode nov-mode) . mixed-pitch-mode)
  :general (general-def-leader "d m" 'mixed-pitch-mode)
  :config
  (setq mixed-pitch-variable-pitch-cursor nil)
  (setq mixed-pitch-set-height t)) ;; keep filled cursor

; * ligatures
(use-package ligature
  :demand t
  :general (general-def-leader "d l" 'ligature-mode)
  :config
  (ligature-set-ligatures
   't
   '("www" "ff" "ffi" "fi" "fj" "fl" "ft" "Fl" "Tl"
     ("-" "-+") ;; horizontal lines
     ("|" "[|-]+") ;; tables
     ("-" "[-|]+")))

  (ligature-set-ligatures
   '(prog-mode eat-mode)
   '("**" "!=" ">=" "<=" "==" "&&" "||"
     ":=" "++" "--" "</" "/>" "::" "__" "#!"
     "/*" "*/" "//" ";;" ";;;" "\\n" "\\\\"
     ("0" "x[0-9A-fa-f]+"))) ;; hexadecimals

  (global-ligature-mode))

; * emojis
(use-package emojify)

; * prettify-symbols-mode
; ** org-mode definitions
(defun sk:prettify-symbols-org-mode ()
  "add org-specific prettifications to 'prettify-symbols-alist'"
  (add-to-list 'prettify-symbols-alist '("#+author" . (?\s (Bc . Bc) ?𝘼)))
  (add-to-list 'prettify-symbols-alist '("#+date" . (?\s (Bc . Bc) ?𝘿)))
  (add-to-list 'prettify-symbols-alist '("#+subtitle" . (?\s (Bc . Bc) ?𝙩)))
  (add-to-list 'prettify-symbols-alist '("#+title" . (?\s (Bc . Bc) ?𝙏))))

(add-hook 'org-mode-hook 'sk:prettify-symbols-org-mode)

; ** org- & latex-mode definitions
(defun sk:prettify-symbols-org-LaTeX-mode ()
  "add latex-specific prettifications to 'prettify-symbols-alist'

also displayed in org documents"
; *** aligned operators
  (add-to-list 'prettify-symbols-alist '("&=&" . "="))
  (add-to-list 'prettify-symbols-alist '("&<&" . "<"))
  (add-to-list 'prettify-symbols-alist '("&>&" . ">"))
  (add-to-list 'prettify-symbols-alist '("&|" . "|"))
  (add-to-list 'prettify-symbols-alist '("\\\\" . (?\s (Bc . Bc) ?⏎)))
  (add-to-list 'prettify-symbols-alist '("&\\approx&" . "≈"))
  (add-to-list 'prettify-symbols-alist '("&\\neq&" . "≠"))
  (add-to-list 'prettify-symbols-alist '("&\\overset{!}{=}&" . (?= (tc . bc) ?!)))
  (add-to-list 'prettify-symbols-alist '("&\\geq&" . "≥"))
  (add-to-list 'prettify-symbols-alist '("&\\leq&" . "≤"))
  (add-to-list 'prettify-symbols-alist '("&\\leftrightarrow&" . (?\s (Bc . Bc) ?↔)))
  (add-to-list 'prettify-symbols-alist '("&\\Leftrightarrow&" . (?\s (Bc . Bc) ?⇔)))
  (add-to-list 'prettify-symbols-alist '("&\\rightleftharpoons&" . (?\s (cl . bl) ?⟶ (bl . cl) ?⟵)))
  (add-to-list 'prettify-symbols-alist '("&\\longrightarrow&" . "⟶"))
  (add-to-list 'prettify-symbols-alist '("&\\longleftarrow&" . "⟵"))

; *** double-struck braces
  (add-to-list 'prettify-symbols-alist '("\\left(" . (?\s (Bc . Bc) ?⸨)))
  (add-to-list 'prettify-symbols-alist '("\\right)" . (?\s (Bc . Bc) ?⸩)))
  (add-to-list 'prettify-symbols-alist '("\\left[" . "⟦"))
  (add-to-list 'prettify-symbols-alist '("\\right]" . "⟧"))
  (add-to-list 'prettify-symbols-alist '("\\left\\{" . "⦃"))
  (add-to-list 'prettify-symbols-alist '("\\right\\}" . "⦄"))
  (add-to-list 'prettify-symbols-alist '("\\left\\vert" . "‖"))
  (add-to-list 'prettify-symbols-alist '("\\right\\vert" . "‖"))
  (add-to-list 'prettify-symbols-alist '("\\left\\Vert" . "⦀"))
  (add-to-list 'prettify-symbols-alist '("\\right\\Vert" . "⦀"))
  (add-to-list 'prettify-symbols-alist '("\\left\\langle" . "⟪"))
  (add-to-list 'prettify-symbols-alist '("\\right\\rangle" . "⟫"))

; *** double-struck letters
  (add-to-list 'prettify-symbols-alist '("\\mathbb{A}" . (?\s (Bc . Bc) ?𝔸)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{B}" . (?\s (Bc . Bc) ?𝔹)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{C}" . (?\s (Bc . Bc) ?ℂ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{D}" . (?\s (Bc . Bc) ?𝔻)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{E}" . (?\s (Bc . Bc) ?𝔼)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{F}" . (?\s (Bc . Bc) ?𝔽)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{G}" . (?\s (Bc . Bc) ?𝔾)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{H}" . (?\s (Bc . Bc) ?ℍ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{I}" . (?\s (Bc . Bc) ?𝕀)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{J}" . (?\s (Bc . Bc) ?𝕁)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{K}" . (?\s (Bc . Bc) ?𝕂)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{L}" . (?\s (Bc . Bc) ?𝕃)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{M}" . (?\s (Bc . Bc) ?𝕄)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{N}" . (?\s (Bc . Bc) ?ℕ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{O}" . (?\s (Bc . Bc) ?𝕆)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{P}" . (?\s (Bc . Bc) ?ℙ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{Q}" . (?\s (Bc . Bc) ?ℚ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{R}" . (?\s (Bc . Bc) ?ℝ)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{S}" . (?\s (Bc . Bc) ?𝕊)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{T}" . (?\s (Bc . Bc) ?𝕋)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{U}" . (?\s (Bc . Bc) ?𝕌)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{V}" . (?\s (Bc . Bc) ?𝕍)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{W}" . (?\s (Bc . Bc) ?𝕎)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{X}" . (?\s (Bc . Bc) ?𝕏)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{Y}" . (?\s (Bc . Bc) ?𝕐)))
  (add-to-list 'prettify-symbols-alist '("\\mathbb{Z}" . (?\s (Bc . Bc) ?ℤ)))

; *** pseudo font effects
  (add-to-list 'prettify-symbols-alist '("\\underline" . "_"))
  (add-to-list 'prettify-symbols-alist '("\\tilde" . "~"))
  (add-to-list 'prettify-symbols-alist '("\\dot" . "·"))
  (add-to-list 'prettify-symbols-alist '("\\ddot" . (?· (Br . Bc) ?·)))
  (add-to-list 'prettify-symbols-alist '("\\dddot" . (?· (Br . Bc) ?· (Br . Bc) ?·)))
  (add-to-list 'prettify-symbols-alist '("\\hat" . "^"))
  (add-to-list 'prettify-symbols-alist '("\\bar" . "–"))
  (add-to-list 'prettify-symbols-alist '("\\vec" . "→"))

; *** misc
  (add-to-list 'prettify-symbols-alist '("\\%" . "%"))
  (add-to-list 'prettify-symbols-alist '("\\bot" . (?\s (Bc . Bc) ?⊥)))
  (add-to-list 'prettify-symbols-alist '("\\degree" . "°"))
  (add-to-list 'prettify-symbols-alist '("\\dollar" . "$"))
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
  (add-to-list 'prettify-symbols-alist '("\\vartheta" . "ϑ")))

; *** activation
(add-hook 'org-mode-hook 'sk:prettify-symbols-org-LaTeX-mode)
(add-hook 'LaTeX-mode-hook 'sk:prettify-symbols-org-LaTeX-mode)

; ** latex-mode definitions
(defun sk:prettify-symbols-LaTeX-mode ()
  "add latex-specific prettifications to 'prettify-symbols-alist'

not displayed in org documents unless in latex env"
  (add-to-list 'prettify-symbols-alist '("&" . "·"))
  (add-to-list 'prettify-symbols-alist '("&&" . (?· (Br . Bl) ?·))))

(add-hook 'LaTeX-mode-hook 'sk:prettify-symbols-LaTeX-mode)

; ** prog-mode definitions
(defun sk:prettify-symbols-prog-mode ()
  "clear, then add general programming prettifications to `prettify-symbols-alist'"
  (setq-local prettify-symbols-alist nil))

(add-hook 'prog-mode-hook 'sk:prettify-symbols-prog-mode)

; ** activation
(general-def-leader
  "t p" 'prettify-symbols-mode)

(global-prettify-symbols-mode)

