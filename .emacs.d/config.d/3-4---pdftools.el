;;; -*- lexical-binding: t; -*-



(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)

  (setq pdf-view-resize-factor 1.1)
  (setq pdf-annot-activate-created-annotations t)

  (add-hook 'pdf-view-mode-hook '(lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
  (add-hook 'text-mode-hook 'evil-insert-state)



  (defun sk:pdf-view-fit ()
    (interactive)
    (if (eq pdf-view-display-size 'fit-height)
        (pdf-view-fit-width-to-window)
      (pdf-view-fit-height-to-window)))



  (general-def '(normal visual) pdf-view-mode-map
    "SPC"     nil
    "<up>"    'pdf-view-previous-line-or-previous-page
    "<down>"  'pdf-view-next-line-or-next-page
    "<left>"  'image-backward-hscroll
    "<right>" 'image-forward-hscroll
    "j"       '(lambda () (interactive) (pdf-view-next-line-or-next-page 4))
    "k"       '(lambda () (interactive) (pdf-view-previous-line-or-previous-page 4))
    "h"       '(lambda () (interactive) (image-backward-hscroll 10))
    "l"       '(lambda () (interactive) (image-forward-hscroll 10))
    "J"       'pdf-view-next-page
    "K"       'pdf-view-previous-page
    "="       'sk:pdf-view-fit)

  (general-def 'visual pdf-view-mode-map :prefix "SPC SPC"
    "w" 'pdf-annot-add-squiggly-markup-annotation
    "h" 'pdf-annot-add-highlight-markup-annotation
    "s" 'pdf-annot-add-strikethrough-markup-annotation
    "u" 'pdf-annot-add-underline-markup-annotation
    "H" 'pdf-annot-add-markup-annotation)

  (general-def '(normal visual) pdf-view-mode-map :prefix "SPC SPC"
    "c" (lambda () (interactive) (pdf-view-redisplay))
    "m" 'pdf-view-midnight-minor-mode
    "t" 'pdf-annot-add-text-annotation
    "d" 'pdf-annot-delete))



; image mode config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'image-mode-hook '(lambda () (display-line-numbers-mode -1)))

(general-def 'normal 'image-mode-map
  "R" 'image-rotate)



(use-package doc-view
  :config
  (setq doc-view-continuous t)

  (defun sk:doc-view-goto-page (count)
    "Goto page COUNT
if COUNT isn't supplied, go to the last page"
      (interactive "P")
      (if count
          (doc-view-goto-page count)
        (doc-view-last-page)))

  (general-def '(normal visual) doc-view-mode-map "G" 'sk:doc-view-goto-page))
