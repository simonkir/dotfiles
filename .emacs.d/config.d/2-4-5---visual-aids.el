;;; -*- lexical-binding: t; -*-



; parentheses ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show-paren-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



; reading / writing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :general ('(normal visual) 'override :prefix "SPC t"
    "v" 'visual-fill-column-mode
    "V" 'set-fill-column)

  :config (setq-default visual-fill-column-center-text t))



; minor mode for reading
(define-minor-mode sk:reading-mode nil
  :global nil
  :init-value nil
  :lighter ""
  :keymap (make-sparse-keymap)
  (if sk:reading-mode
      ;; on activation
      (progn
        (setq-local line-spacing 0.5)
        ;;(global-hl-line-mode 0)
        ;;(global-display-line-numbers-mode 0)
        (blink-cursor-mode 0)
        (read-only-mode 1)
        (visual-fill-column-mode 1)
        (set-fill-column 18)
        (text-scale-set 3)
        (redraw-display)
        (evil-normalize-keymaps))

    ;; on deactivation
    (setq-local line-spacing 0)
    ;;(global-hl-line-mode 1)
    ;;(global-display-line-numbers-mode 1)
    (blink-cursor-mode 1)
    (read-only-mode 0)
    (visual-fill-column-mode 0)
    (text-scale-set 0)
    (redraw-display)))

(general-def '(normal visual) sk:reading-mode-map
  "<left>"  'evil-scroll-page-up
  "<right>" 'evil-scroll-page-down
  "<up>"    'evil-scroll-line-up
  "<down>"  'evil-scroll-line-down)

(general-def '(normal visual) 'override
  "SPC d w" 'sk:reading-mode)



; text scale
(general-def '(normal visual) 'override :prefix "SPC"
  "0" 'text-scale-adjust
  "+" 'text-scale-adjust
  "-" 'text-scale-adjust)



; indent guides ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :hook ((prog-mode org-mode LaTeX-mode) . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'bitmap))



; visual undo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vundo
  :general ('normal override "U" 'vundo)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols)
  (general-def 'normal vundo-mode-map
    "j" 'vundo-next
    "k" 'vundo-previous))
