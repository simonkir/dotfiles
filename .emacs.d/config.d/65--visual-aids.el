;;; -*- lexical-binding: t; -*-



; writing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :general (general-def-leader
    "t v" 'visual-fill-column-mode
    "t V" 'set-fill-column)

  :config (setq-default visual-fill-column-center-text t))



; text scale ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def-leader
  "0" 'text-scale-adjust
  "+" 'text-scale-adjust
  "-" 'text-scale-adjust)



; indent guides ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :hook ((prog-mode org-mode LaTeX-mode) . highlight-indent-guides-mode)
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
           (row (append (make-list padding-left zrep) (make-list line-width crep) (make-list padding-right zrep)))
           rows)
      (dotimes (i character-height rows)
        (setq rows (cons row rows)))))

  (setq highlight-indent-guides-bitmap-function 'sk:highlight-indent-guides--bitmap-line)
  (setq highlight-indent-guides-method 'bitmap)

  ;; face settings
  (setq highlight-indent-guides-auto-character-face-perc 25)
  (setq highlight-indent-guides-auto-top-character-face-perc 60)

  ;; responsive setting
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-delay 0))
