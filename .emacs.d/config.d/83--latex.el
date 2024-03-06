;;; -*- lexical-binding: t; -*-

; * auctex
(use-package tex
  :ensure auctex
  :init
  ;; in init because org-mode needs it too
  (setq texmathp-tex-commands '())
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray" env-on)))
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray\*" env-on)))

  :config
; ** general settings
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-error-overview-open-after-TeX-run nil)

  (add-hook 'LaTeX-mode-hook #'sk:autocorrect-mode)

  (add-hook 'LaTeX-mode-hook #'(lambda () (modify-syntax-entry ?\\ "w")))
  (add-hook 'LaTeX-mode-hook #'(lambda () (modify-syntax-entry ?$ "$")))
  (add-hook 'LaTeX-mode-hook #'(lambda () (modify-syntax-entry ?| "$")))

  (general-def 'LaTeX-mode-map
    "$" nil)

; ** output / viewing
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (setq TeX-source-correlate-mode t)

  (add-to-list 'TeX-source-correlate-method '(pdf . synctex))

; ** math settings
  (setq TeX-insert-braces nil)

  (setq preview-scale-function      1.5)
  (setq preview-auto-cache-preamble t))

; * sklatex
(use-package sklatex
  :ensure nil
  :hook
  ((LaTeX-mode org-mode) . sklatex-mode)

  :config
  (sklatex-default-setup)

  (general-def '(org-mode-map LaTeX-mode-map)
    "C-c C-a" 'sklatex-dispatch
    "C-c A" 'sklatex-mode))


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

  (defun cdlatex--texmathp () t)

; ** cdlatex-math-symbol-alist
  (setq cdlatex-math-symbol-alist
        '((?c ("\\quad" "" "\\cos"))
          (?e ("\\varepsilon" "\\epsilon" "\\exp"))
          (?f ("\\varphi" "\\phi" ""))
          (?F ("\\Phi" "" ""))
          (?I ("\\notin" "\\Im" ""))
          (?P ("\\prod" "\\Pi" ""))
          (?S ("\\sum" "\\Sigma" "\\arcsin"))
          (?w ("\\omega" "" ""))
          (?X ("\\xi" "" ""))
          (?~ ("\\approx" "\\sim" "\\leadsto"))
          (?- ("\\leftrightarrow" "\\Leftrightarrow" "\\rightleftharpoons"))
          (?> ("\\rightarrow" "\\Rightarrow" "\\longrightarrow"))
          (?< ("\\leftarrow" "\\Leftarrow" "\\longleftarrow"))
          (?\( ("\\subset" "\\subseteq" ""))
          (?\) ("\\supset" "\\supseteq" ""))
          (?| ("\\BAR" "\\mapsto" "\\longmapsto"))
          (?$ ("\\mid" "" ""))
          (?% ("\\nmid" "" ""))
          (?/ ("\\lor" "\\cup" ""))
          (?& ("\\land" "\\cap" "\\wedge"))
          (?! ("\\neg" "\\lightning" ""))
          (?= ("\\neq" "" ""))
          (?° ("\\degree" "" ""))
          (?+ ("\\pm" "" ""))
          (?: ("\\ldots" "" ""))))

; ** cdlatex-math-modify-alist
  (setq cdlatex-math-modify-alist
        '((?. "\\dot"  nil t nil nil)
          (?: "\\ddot" nil t nil nil)
          (?- "\\bar"  nil t nil nil)
          (?> "\\vec"  nil t nil nil))))
