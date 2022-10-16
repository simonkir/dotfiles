;;; -*- lexical-binding: t; -*-



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
    (read-only-mode 0)
    (visual-fill-column-mode 0)
    (text-scale-set 0)
    (redraw-display)))

;;(general-def '(normal visual) sk:reading-mode-map
;;  "<left>"  'evil-scroll-page-up
;;  "<right>" 'evil-scroll-page-down
;;  "<up>"    'evil-scroll-line-up
;;  "<down>"  'evil-scroll-line-down)

(general-def-leader
  "SPC d w" 'sk:reading-mode)
