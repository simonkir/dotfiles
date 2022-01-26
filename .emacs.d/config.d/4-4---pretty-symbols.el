;;; -*- lexical-binding: t; -*-




; prettify symbols mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sk:prettify-symbols-prog-mode ()
  ;;(add-to-list 'prettify-symbols-alist '("*" . "×")) ;; very similar to x
  ;;(add-to-list 'prettify-symbols-alist '("/" . "÷")) ;; very similar to +
  (add-to-list 'prettify-symbols-alist '("pi" . "π"))
  (add-to-list 'prettify-symbols-alist '("sqrt" . "√"))
  (add-to-list 'prettify-symbols-alist '("^2" . "²"))
  (add-to-list 'prettify-symbols-alist '("^3" . "³"))
  (add-to-list 'prettify-symbols-alist '("&&" . "⋀"))
  (add-to-list 'prettify-symbols-alist '("||" . "⋁"))
  (add-to-list 'prettify-symbols-alist '("!" . "¬"))
  (add-to-list 'prettify-symbols-alist '("!=" . "≠"))
  (add-to-list 'prettify-symbols-alist '("<=" . "≤"))
  (add-to-list 'prettify-symbols-alist '(">=" . "≥"))
  (add-to-list 'prettify-symbols-alist '("++" . "△"))
  (add-to-list 'prettify-symbols-alist '("--" . "▽"))
  (add-to-list 'prettify-symbols-alist '("null" . "Ø"))
  (add-to-list 'prettify-symbols-alist '("true" . "𝕋"))
  (add-to-list 'prettify-symbols-alist '("false" . "𝔽"))
  ;;(add-to-list 'prettify-symbols-alist '("private" . "☐"))
  ;;(add-to-list 'prettify-symbols-alist '("protected" . "☑"))
  ;;(add-to-list 'prettify-symbols-alist '("public" . "✓"))
  (add-to-list 'prettify-symbols-alist '("import" . "▶"))
  (add-to-list 'prettify-symbols-alist '("void" . "ƒ"))
  (add-to-list 'prettify-symbols-alist '("double" . "ℚ"))
  (add-to-list 'prettify-symbols-alist '("int" . "ℤ"))
  (add-to-list 'prettify-symbols-alist '("return" . "⟼")))

(defun sk:prettify-symbols-java-mode ()
  ;;(add-to-list 'prettify-symbols-alist '((?\x2f?\x2f) . "◆")) ; comment ("//")
  ;;(add-to-list 'prettify-symbols-alist '("final" . "🔒"))
  ;;(add-to-list 'prettify-symbols-alist '("static" . "‰"))
  (add-to-list 'prettify-symbols-alist '("String" . "𝕊"))
  (add-to-list 'prettify-symbols-alist '("boolean" . "𝔹")))

(defun sk:prettify-symbols-python-mode ()
  (add-to-list 'prettify-symbols-alist '("from" . "▷"))
  (add-to-list 'prettify-symbols-alist '("and" . "⋀"))
  (add-to-list 'prettify-symbols-alist '("or" . "⋁"))
  (add-to-list 'prettify-symbols-alist '("def" . "ƒ")))

(general-def 'normal 'override
  "SPC t p" 'prettify-symbols-mode)

(add-hook 'prog-mode-hook 'sk:prettify-symbols-prog-mode())
(add-hook 'java-mode-hook 'sk:prettify-symbols-java-mode())
(add-hook 'python-mode-hook 'sk:prettify-symbols-python-mode())

(global-prettify-symbols-mode)
