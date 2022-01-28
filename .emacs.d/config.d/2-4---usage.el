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
  :hook (prog-mode . rainbow-delimiters-mode))



; insertion  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default tab-width 4)



(use-package evil-lion
  :ensure t
  :after evil
  :general ('(normal visual) 'override :prefix "g"
            "l" 'evil-lion-left
            "L" 'evil-lion-right))



(use-package evil-surround
  :ensure t
  :after evil
  :defer 1
  :config (global-evil-surround-mode 1))



(use-package popup-kill-ring
  :ensure t
  :general ('insert "M-y" 'popup-kill-ring))



; autocompletion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :ensure t
  :hook
  (after-init . company-tng-mode)
  (after-init . global-company-mode)

  :config
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 2)
  (general-def company-active-map "C-w" 'evil-delete-backward-word))




(use-package company-math
  :ensure t
  :after company
  :config (add-to-list 'company-backends 'company-math-symbols-unicode))



; snippets & templates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :ensure t
  :demand t
  :config (yas-global-mode))



(use-package autoinsert
  :demand t
  :config
  (setq auto-insert t)
  (setq auto-insert-directory "~/.emacs.d/templates/")
  (define-auto-insert 'org-mode "org-mode.org")
  (auto-insert-mode t))



; buffer handling  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-auto-revert-mode)

(general-def 'normal
  "g r" 'revert-buffer)



; spell checking  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flyspell
  :defer t
  :general ('normal 'override :prefix "SPC t"
                    "s" 'sk:flyspell-mode
                    "S" 'ispell-change-dictionary)

  :config
  (setq flyspell-issue-message-flag nil)
  (setq ispell-dictionary "de_DE")
  (defun sk:flyspell-mode ()
    (interactive)
    (if (bound-and-true-p flyspell-mode)
        (flyspell-mode 0)
      (flyspell-mode 1)
      (flyspell-buffer))))



; visual aids  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :ensure t
  :general ('normal 'override :prefix "SPC t"
                    "v" 'visual-fill-column-mode
                    "V" 'set-fill-column)

  :config (setq visual-fill-column-center-text t))



; text scale
(general-def 'normal 'override :prefix "SPC"
 "0" 'text-scale-adjust
 "+" 'text-scale-adjust
 "-" 'text-scale-adjust)



; font settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-face-attribute 'default nil :family "Source Code Pro" :height 100)
(set-face-attribute 'fixed-pitch nil :family "Source Code Pro")
(set-face-attribute 'variable-pitch nil :family "Noto Serif")

(use-package mixed-pitch
  :ensure t
  :hook ((org-mode TeX-mode) . mixed-pitch-mode)
  :general ('normal 'override "SPC t m" 'mixed-pitch-mode)
  :config (setq mixed-pitch-variable-pitch-cursor nil)) ;; keep filled cursor
