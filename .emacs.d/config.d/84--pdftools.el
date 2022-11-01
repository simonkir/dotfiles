;;; -*- lexical-binding: t; -*-



(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq pdf-view-resize-factor 1.1)
  (setq pdf-annot-activate-created-annotations t)

  (add-hook 'pdf-view-mode-hook #'(lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-annot-minor-mode)



  (defun sk:pdf-view-fit ()
    "fits pdf into window (alternating between fit-height and fit-width)"
    (interactive)
    (if (eq pdf-view-display-size 'fit-height)
        (pdf-view-fit-width-to-window)
      (pdf-view-fit-height-to-window)))



  (general-def pdf-view-mode-map
    "h" 'image-backward-hscroll
    "j" 'pdf-view-next-line-or-next-page
    "k" 'pdf-view-previous-line-or-previous-page
    "l" 'image-forward-hscroll

    "<down>"  #'(lambda () (interactive) (pdf-view-next-line-or-next-page 4))
    "<up>"    #'(lambda () (interactive) (pdf-view-previous-line-or-previous-page 4))
    "<left>"  #'(lambda () (interactive) (image-backward-hscroll 10))
    "<right>" #'(lambda () (interactive) (image-forward-hscroll 10))
    "J"       'pdf-view-next-page
    "K"       'pdf-view-previous-page

    "b" 'pdf-view-set-slice-from-bounding-box
    "B" 'pdf-view-reset-slice
    "M" 'pdf-view-goto-page
    "=" 'sk:pdf-view-fit)

  (general-def-localleader pdf-view-mode-map
    "w" 'pdf-annot-add-squiggly-markup-annotation
    "h" 'pdf-annot-add-highlight-markup-annotation
    "s" 'pdf-annot-add-strikethrough-markup-annotation
    "u" 'pdf-annot-add-underline-markup-annotation
    "H" 'pdf-annot-add-markup-annotation
    "t" 'pdf-annot-add-text-annotation
    "d" 'pdf-annot-delete

    "c" #'(lambda () (interactive) (pdf-view-redisplay t))
    "m" 'pdf-view-midnight-minor-mode))



(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode -1)))

(general-def image-mode-map
  "<" nil
  ">" nil
  "< l" 'image-bol
  "> l" 'image-eol
  "< b" 'image-bob
  "> b" 'image-eob

  "W" 'image-transform-fit-to-width
  "H" 'image-transform-fit-to-height

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

  (general-def doc-view-mode-map
    "G" 'sk:doc-view-goto-page))
