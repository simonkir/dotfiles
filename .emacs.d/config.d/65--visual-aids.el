;;; -*- lexical-binding: t; -*-

; * visual-fill-column
(use-package visual-fill-column
  :general (general-def-leader
    "t v" 'visual-fill-column-mode
    "t V" 'set-fill-column)

  :config (setq-default visual-fill-column-center-text t))

; * outline mode
(use-package outline
  :hook (prog-mode . outline-minor-mode)
  :config
  (setq outline-minor-mode-cycle t)
  ;;(setq outline-default-state 1)

  (add-hook 'prog-mode-hook #'(lambda () (setq-local outline-regexp (concat comment-start "+ *\\*+"))))

  (general-def-leader
    "v n" 'outline-next-visible-heading
    "v p" 'outline-previous-visible-heading
    "v f" 'outline-forward-same-level
    "v b" 'outline-backward-same-level
    "v u" 'outline-up-heading
    "v l" 'outline-show-branches
    "v v" 'outline-show-only-headings
    "v a" 'outline-show-all))

; * indent guides
(use-package highlight-indent-guides
  :hook ((prog-mode) . highlight-indent-guides-mode)
  :general (general-def-leader "t h" 'highlight-indent-guides-mode)
  :config
  ;; bitmap settings
  (defun sk:highlight-indent-guides--bitmap-line (character-width character-height crep zrep)
    "Defines a solid guide line, two pixels wide.
Use WIDTH, HEIGHT, CREP, and ZREP as described in
`highlight-indent-guides-bitmap-function'."
    (let* ((line-width 1)
           (padding-left (/ (- character-width line-width) 2))
           (padding-right (- character-width padding-left line-width))
           (row (append (make-list padding-left zrep)
                        (make-list line-width crep)
                        (make-list padding-right zrep)))
           rows)
      (dotimes (i character-height rows)
        (setq rows (cons row rows)))))

  (setq highlight-indent-guides-bitmap-function #'sk:highlight-indent-guides--bitmap-line)
  (setq highlight-indent-guides-method 'bitmap)

  ;; face settings
  (setq highlight-indent-guides-auto-character-face-perc 25)
  (setq highlight-indent-guides-auto-top-character-face-perc 60)

  ;; responsive setting
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-delay 0))

