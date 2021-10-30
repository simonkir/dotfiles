;;; -*- lexical-binding: t; -*-



; parenthesis ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show-paren-mode)

(use-package electric
  :demand t
  :config
  (electric-pair-mode t)

  (add-to-list 'electric-pair-pairs '(8218 . 8216)) ;; ‚‘
  (add-to-list 'electric-pair-pairs '(8222 . 8220)) ;; „“

  (defun sk:electric-add-latex-parenthesis ()
    (interactive)
    (make-local-variable 'electric-pair-pairs)
    (add-to-list 'electric-pair-pairs '(36 . 36))) ;; $|$

  (add-hook 'org-mode-hook 'sk:electric-add-latex-parenthesis)
  (add-hook 'TeX-mode-hook 'sk:electric-add-latex-parenthesis))



(use-package rainbow-delimiters
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))



; insertion  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-lion
  :after evil
  :ensure t
  :general ('(normal visual) 'override :prefix "g"
            "l" 'evil-lion-left
            "L" 'evil-lion-right))



(use-package evil-surround
  :after evil
  :defer 1
  :ensure t
  :config
  (global-evil-surround-mode 1))



(use-package popup-kill-ring
  :ensure t
  :general ('insert "M-y" 'popup-kill-ring))



; autocompletion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :ensure t
  :custom
  (company-idle-delay 0.3)
  (company-minimum-prefix-length 2)

  :config
  (general-def company-active-map "C-w" 'evil-delete-backward-word)

  :hook
  ((after-init . company-tng-mode)
   (after-init . global-company-mode)))



(use-package company-math
  :after company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-math-symbols-unicode))



; snippets & templates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :demand t
  :ensure t
  :config
  (yas-global-mode))



(use-package yasnippet-snippets
  :after yasnippet
  :ensure t
  :config
  (yas-reload-all))



(use-package autoinsert
  :demand t
  :custom
  (auto-insert t)
  (auto-insert-directory "~/.emacs.d/templates/")

  :config
  (define-auto-insert 'org-mode "org-mode.org")
  (auto-insert-mode t))



; buffer handling  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-auto-revert-mode)

(general-def 'normal
  "g r" 'revert-buffer)



; spell checking  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flyspell
  :custom
  (flyspell-issue-message-flag nil)
  (ispell-dictionary "de_DE")

  :config
  (defun sk:flyspell-mode ()
    (interactive)
    (if (bound-and-true-p flyspell-mode)
        (flyspell-mode 0)
      (flyspell-mode 1)
      (flyspell-buffer)))

  :general ('normal 'override :prefix "SPC t"
                    "s" 'sk:flyspell-mode
                    "S" 'ispell-change-dictionary))


; visual aids  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :ensure t
  :custom
  (visual-fill-column-center-text t)

  :general ('normal 'override :prefix "SPC t"
                    "v" 'visual-fill-column-mode
                    "V" 'set-fill-column))



; text scale
(general-def 'normal 'override :prefix "SPC"
 "0" 'text-scale-adjust
 "+" 'text-scale-adjust
 "-" 'text-scale-adjust)



(use-package pretty-mode
  :after python
  :ensure t
  :hook
  (python-mode . turn-on-pretty-mode))



; font settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-face-attribute 'default nil :family "Source Code Pro" :height 100)
(set-face-attribute 'fixed-pitch nil :family "Source Code Pro")
(set-face-attribute 'variable-pitch nil :family "Noto Serif")

(use-package mixed-pitch
  :ensure t
  :custom
  (mixed-pitch-variable-pitch-cursor nil) ;; keep filled cursor

  :hook
  ((org-mode TeX-mode) . mixed-pitch-mode)

  :general ('normal 'override "SPC t m" 'mixed-pitch-mode))
