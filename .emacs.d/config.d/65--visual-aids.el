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
  (defun sk:highlight-indent-guides--bitmap-line (width height crep zrep)
    "Defines a solid guide line, two pixels wide.
Use WIDTH, HEIGHT, CREP, and ZREP as described in
`highlight-indent-guides-bitmap-function'."
    (let* ((left (/ (- width 1) 2))
           (right (- width left 1))
           (row (append (make-list left zrep) (make-list 1 crep) (make-list right zrep)))
           rows)
      (dotimes (i height rows)
        (setq rows (cons row rows)))))

  (setq highlight-indent-guides-bitmap-function 'sk:highlight-indent-guides--bitmap-line)
  (setq highlight-indent-guides-method 'bitmap))
