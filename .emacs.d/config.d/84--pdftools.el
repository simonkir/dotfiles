;;; -*- lexical-binding: t; -*-



(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq pdf-view-resize-factor 1.1)
  (setq pdf-annot-activate-created-annotations t)

  (add-hook 'pdf-view-mode-hook #'(lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-view-mode-hook 'pdf-annot-minor-mode)



  (defun sk:pdf-view-fit ()
    (interactive)
    (if (eq pdf-view-display-size 'fit-height)
        (pdf-view-fit-width-to-window)
      (pdf-view-fit-height-to-window)))



  (bind-keys :map pdf-view-mode-map
    ("<up>"    . pdf-view-previous-line-or-previous-page)
    ("<down>"  . pdf-view-next-line-or-next-page)
    ("<left>"  . image-backward-hscroll)
    ("<right>" . image-forward-hscroll)

    ("j"       . (lambda () (interactive) (pdf-view-next-line-or-next-page 4)))
    ("k"       . (lambda () (interactive) (pdf-view-previous-line-or-previous-page 4)))
    ("h"       . (lambda () (interactive) (image-backward-hscroll 10)))
    ("l"       . (lambda () (interactive) (image-forward-hscroll 10)))
    ("J"       . pdf-view-next-page)
    ("K"       . pdf-view-previous-page)
    ("<home>"  . image-bol)
    ("<end>"   . image-eol)
    ("<prior>" . image-bob)
    ("<next>"  . image-eob)

    ("W"       . pdf-view-fit-width-to-window)
    ("H"       . pdf-view-fit-height-to-window)
    ("="       . sk:pdf-view-fit))

  ;;(general-def 'visual pdf-view-mode-map
  ;;  "SPC SPC w" 'pdf-annot-add-squiggly-markup-annotation
  ;;  "SPC SPC h" 'pdf-annot-add-highlight-markup-annotation
  ;;  "SPC SPC s" 'pdf-annot-add-strikethrough-markup-annotation
  ;;  "SPC SPC u" 'pdf-annot-add-underline-markup-annotation
  ;;  "SPC SPC H" 'pdf-annot-add-markup-annotation)

  ;;(general-def '(normal visual) pdf-view-mode-map
  ;;  "SPC SPC c" (lambda () (interactive) (pdf-view-redisplay))
  ;;  "SPC SPC m" 'pdf-view-midnight-minor-mode

  ;;  "SPC SPC t" 'pdf-annot-add-text-annotation
  ;;  "SPC SPC d" 'pdf-annot-delete))
  )



(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode -1)))

(define-key image-mode-map "R" 'image-rotate)



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

  (bind-keys :map doc-view-mode-map
    ("G" . sk:doc-view-goto-page)))
