;;; -*- lexical-binding: t; -*-

; * auctex
(use-package tex
  :ensure auctex
  :pin manual
  :init
  ;; in init because org-mode needs it too
  (setq texmathp-tex-commands
        '(("IEEEeqnarray" env-on)
          ("IEEEeqnarray\*" env-on)))

  :config
; ** general settings
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-error-overview-open-after-TeX-run nil)
  (setq LaTeX-indent-level 0)

  (add-hook 'LaTeX-mode-hook #'(lambda ()
                                 (modify-syntax-entry ?\\ "w")
                                 (modify-syntax-entry ?$ "$")))

; ** compilation, output, viewing
  (setq-default TeX-engine 'luatex)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (add-to-list 'TeX-source-correlate-method '(pdf . synctex))

  (TeX-source-correlate-mode)

; ** parens
  (setq TeX-insert-braces nil)
  (general-def 'LaTeX-mode-map
    "$" nil)

; ** math settings
  (setq preview-scale-function 1.5)
  (setq preview-auto-cache-preamble t))

; ** auctex-latexmk
(use-package auctex-latexmk
  :after tex
  :demand t
  :config
  (auctex-latexmk-setup))

; * sklatex
(use-package sklatex
  :ensure nil
  :hook ((LaTeX-mode org-mode) . sklatex-mode)
  :config
  (general-def sklatex-mode-map
    "C-a" 'sklatex-remove-effect-at-point))

; * cdlatex
(use-package cdlatex
  :hook
  (LaTeX-mode . cdlatex-mode)
  (org-mode . org-cdlatex-mode)

  :init
  (setq cdlatex-math-symbol-prefix ?#)
  (setq cdlatex-math-modify-prefix ?°)
  (setq cdlatex-takeover-dollar nil)

  :config
; ** general settings
  (setq cdlatex-paired-parens "")
  (setq cdlatex-simplify-sub-super-scripts nil)
  (setq cdlatex-sub-super-scripts-outside-math-mode nil)

  (setq cdlatex-auto-help-delay most-positive-fixnum)

  ;; needed for sklatex alignment defuns
  (advice-add 'cdlatex-math-symbol :after #'(lambda () (run-hooks 'post-self-insert-hook)))

  (general-def org-cdlatex-mode-map
    "'" nil
    "°" 'cdlatex-math-modify
    "#" 'cdlatex-math-symbol
    "_" 'cdlatex-sub-superscript
    "^" 'cdlatex-sub-superscript)

  (general-def cdlatex-mode-map
    "$" nil
    "|" nil
    "(" nil
    "[" nil
    "{" nil
    "TAB" nil
    "<tab>" nil)

; ** cdlatex-math-symbol-alist
  (setq cdlatex-math-symbol-alist
        '((?a ("\\alpha" "" ""))
          (?A ("\\forall" "\\aleph" ""))
          (?b ("\\beta" "" ""))
          (?B ("\\bot" "\\mathcal{B}" ""))
          (?c ("" "" "\\cos"))
          (?C ("" "\\mathbb{C}" "\\arccos"))
          (?d ("\\delta" "\\partial" ""))
          (?D ("\\Delta" "\\nabla" ""))
          (?e ("\\varepsilon" "\\epsilon" "\\exp"))
          (?E ("\\exists" "" "\\ln"))
          (?f ("\\varphi" "\\phi" ""))
          (?F ("\\Phi" "" ""))
          (?g ("\\gamma" "" "\\lg"))
          (?G ("\\Gamma" "" "10^{?}"))
          (?h ("" "" ""))
          (?H ("" "" ""))
          (?i ("\\in" "\\imath" ""))
          (?I ("\\notin" "\\Im" ""))
          (?j ("" "\\jmath" ""))
          (?J ("" "" ""))
          (?k ("\\kappa" "" ""))
          (?K ("" "\\mathbb{K}" ""))
          (?l ("\\lambda" "\\ell" "\\log"))
          (?L ("\\Lambda" "\\mathcal{L}" "\\mathcal{L}"))
          (?m ("\\mu" "" ""))
          (?M ("" "" ""))
          (?n ("\\eta" "" "\\ln"))
          (?N ("" "\\mathbb{N}" ""))
          (?p ("\\pi" "\\varpi" ""))
          (?P ("\\Pi" "" ""))
          (?q ("\\vartheta" "\\theta" ""))
          (?Q ("\\Theta" "\\mathbb{Q}" ""))
          (?r ("\\rho" "\\varrho" ""))
          (?R ("" "\\mathbb {R}" ""))
          (?s ("\\sigma" "\\varsigma" "\\sin"))
          (?S ("\\Sigma" "\\mathcal{S}" "\\arcsin"))
          (?t ("\\tau" "" "\\tan"))
          (?T ("\\top" "" "\\arctan"))
          (?u ("\\upsilon" "" ""))
          (?U ("\\Upsilon" "" ""))
          (?v ("\\nu" "\\vee" ""))
          (?V ("" "\\mathcal{V}" ""))
          (?w ("\\omega" "" ""))
          (?W ("\\Omega" "\\mho" ""))
          (?x ("\\xi" "" ""))
          (?X ("\\chi" "\\Xi" ""))
          (?y ("\\psi" "" ""))
          (?Y ("\\Psi" "" ""))
          (?z ("\\zeta" "" ""))
          (?Z ("" "\\mathbb{Z}" ""))

          (?° ("\\degree" "" ""))
          (?! ("\\neg" "\\lightning" ""))
          (?% ("\\nmid" "" ""))
          (?$ ("\\mid" "" ""))
          (?& ("\\wedge" "" ""))
          (?/ ("\\lor" "\\cup" ""))
          (?8 ("\\infty" "" ""))
          (?\( ("\\subset" "\\subseteq" ""))
          (?\) ("\\supset" "\\supseteq" ""))
          (?0 ("\\emptyset" "" ""))
          (?= ("\\Leftrightarrow" "\\Longleftrightarrow" ""))
          (?\ ("\\setminus" "" ""))

          (?~ ("\\approx" "\\sim" "\\leadsto"))
          (?- ("\\leftrightarrow" "\\longleftrightarrow" "\\rightleftharpoons"))
          (?+ ("\\pm" "" ""))
          (?* ("\\times" "\\otimes" "\\circ"))
          (?| ("\\mapsto" "\\longmapsto" ""))
          (?< ("\\leftarrow" "\\Leftarrow" "\\longleftarrow"))
          (?> ("\\rightarrow" "\\Rightarrow" "\\longrightarrow"))
          (?' ("\\prime" "" ""))
          (?. ("\\cdot" "" ""))
          (?: ("\\ldots" "" ""))))

; ** cdlatex-math-modify-alist
  (setq cdlatex-math-modify-alist
        '((?d "\\mathbb" nil t nil nil)
          (?~ "\\tilde" nil t nil nil)
          (?^ "\\hat" nil t nil nil)
          (?. "\\dot" nil t nil nil)
          (?: "\\ddot" nil t nil nil)
          (?… "\\dddot" nil t nil nil)
          (?- "\\bar" nil t nil nil)
          (?> "\\vec" nil t nil nil))))
