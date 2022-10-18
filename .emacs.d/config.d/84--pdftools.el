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
    "fits pdf into window (alternating between fit-height and fit-width)"
    (interactive)
    (if (eq pdf-view-display-size 'fit-height)
        (pdf-view-fit-width-to-window)
      (pdf-view-fit-height-to-window)))



  (general-def pdf-view-mode-map
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
    
    "<home>"  'image-bol
    "<end>"   'image-eol
    "<prior>" 'image-bob
    "<next>"  'image-eob
    
    "M"       'pdf-view-goto-page
    "W"       'pdf-view-fit-width-to-window
    "H"       'pdf-view-fit-height-to-window
    "="       'sk:pdf-view-fit)

  (general-def-localleader pdf-view-mode-map
    "w" 'pdf-annot-add-squiggly-markup-annotation
    "h" 'pdf-annot-add-highlight-markup-annotation
    "s" 'pdf-annot-add-strikethrough-markup-annotation
    "u" 'pdf-annot-add-underline-markup-annotation
    "H" 'pdf-annot-add-markup-annotation
    "t" 'pdf-annot-add-text-annotation
    "d" 'pdf-annot-delete

    "c" (lambda () (interactive) (pdf-view-redisplay))
    "m" 'pdf-view-midnight-minor-mode))
    


(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode -1)))

(general-def image-mode-map "R" 'image-rotate)



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

  (general-def doc-view-mode-map
    "G" 'sk:doc-view-goto-page))
