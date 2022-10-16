;;; -*- lexical-binding: t; -*-



(use-package tex
  :ensure auctex
  :init
  ;; in init because org-mode needs it too
  (setq texmathp-tex-commands '())
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray" env-on)))
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray\*" env-on)))



  :config
  (setq TeX-auto-save  t)
  (setq TeX-parse-self t)
  (setq TeX-error-overview-open-after-TeX-run nil)

  (add-hook 'LaTeX-mode-hook 'sk:autocorrect-mode)



  ; output / viewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (setq TeX-source-correlate-mode  t)
  (add-to-list 'TeX-source-correlate-method '(pdf . synctex))



  ; math settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode
  ;;(setq LaTeX-math-abbrev-prefix "#")
  (setq TeX-insert-braces nil)

  (setq preview-scale-function      1.5)
  (setq preview-auto-cache-preamble t)



  ; mappings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;(general-def '(normal visual) TeX-mode-map
  ;;  "SPC SPC s"   'LaTeX-section            ;; insert section
  ;;  "SPC SPC e"   'LaTeX-environment        ;; insert environment
  ;;  "SPC SPC TAB" 'LaTeX-fill-environment)  ;; auto-indent
  ;;
  ;;(general-def '(normal visual) TeX-mode-map
  ;;  "SPC SPC l l" 'preview-at-point
  ;;  "SPC SPC l L" 'preview-clearout-at-point
  ;;  "SPC SPC l b" 'preview-buffer
  ;;  "SPC SPC l B" 'preview-clearout-buffer))
  )



(use-package sklatex
  :ensure nil
  :hook
  (LaTeX-mode . sklatex-mode)
  (org-mode . sklatex-mode)

  ;;:config
  ;;(general-def 'normal (org-mode-map TeX-mode-map)
  ;;  "SPC SPC k" 'sklatex-dispatch
  ;;  "SPC SPC K" 'sklatex-mode)
  )



(use-package cdlatex
  :hook
  (LaTeX-mode . cdlatex-mode)
  (org-mode . org-cdlatex-mode)

  :init
  (setq cdlatex-math-symbol-prefix ?#)

  :config
  (general-def org-cdlatex-mode-map
    "$" 'cdlatex-dollar)

  (setq cdlatex-simplify-sub-super-scripts nil)
  (setq cdlatex-paired-parens "$([{")
  (setq cdlatex-math-symbol-alist
        '((?F ("\\Phi"))
          (?w ("\\omega"))
          (?X ("\\xi"))
          (?- ("\\leftrightarrow" "\\Leftrightarrow" "&\\rightleftharpoons&"))
          (?> ("\\rightarrow" "\\Rightarrow" "&\\longrightarrow&"))
          (?< ("\\leftarrow" "\\Leftarrow" "&\\longleftarrow&"))
          (?| ("\\lor" "\\mapsto" "\\longmapsto"))
          (?/ ("\\lor" "" ""))
          (?& ("\\land" "\\wedge" ""))
          (?! ("\\not" "" ""))
          (?= ("\\neq" "" ""))
          (?+ ("\\pm"))
          (?: ("\\ldots"))
          (?c ("\\quad" "" "\\cos"))))

  (setq cdlatex-math-modify-alist
        '((?. "\\dot"  nil t nil nil)
          (?: "\\ddot" nil t nil nil)
          (?- "\\bar"  nil t nil nil)
          (?> "\\vec"  nil t nil nil)))

  (general-def cdlatex-mode-map
    "TAB" 'nil
    "<tab>" 'nil)

  (general-def org-mode-map
    "#" 'cdlatex-math-symbol))



;;(use-package evil-tex
;;  :hook ((LaTeX-mode org-mode) . evil-tex-mode)
;;  :config
;;  (general-def evil-tex-delim-map
;;    "(" 'evil-tex-delims---\\left\(
;;    ")" 'evil-tex-delims---\\left\(
;;    "[" 'evil-tex-delims---\\left\[
;;    "]" 'evil-tex-delims---\\left\[
;;    "{" 'evil-tex-delims---\\left\\{
;;    "}" 'evil-tex-delims---\\left\\{
;;    "|" 'evil-tex-delims---\\left\\vert))
