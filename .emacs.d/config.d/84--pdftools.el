;;; -*- lexical-binding: t; -*-



(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-resize-factor 1.1)
  (setq pdf-annot-activate-created-annotations t)
  (setq pdf-view-midnight-invert nil)

  (add-hook 'pdf-view-mode-hook #'(lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-view-auto-slice-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-annot-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-isearch-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-outline-minor-mode)



  (general-def pdf-view-mode-map
    "j" #'(lambda () (interactive) (pdf-view-next-line-or-next-page 4))
    "k" #'(lambda () (interactive) (pdf-view-previous-line-or-previous-page 4))
    "h" #'(lambda () (interactive) (image-backward-hscroll 10))
    "l" #'(lambda () (interactive) (image-forward-hscroll 10))
    "<up>" 'pdf-view-previous-line-or-previous-page
    "<left>" 'image-backward-hscroll
    "<down>" 'pdf-view-next-line-or-next-page
    "<right>" 'image-forward-hscroll
    "J" 'pdf-view-next-page
    "K" 'pdf-view-previous-page
    "M" 'pdf-view-goto-page

    "=" nil
    "s a" 'pdf-view-auto-slice-minor-mode
    "s s" 'pdf-view-set-slice-using-mouse
    "s b" 'pdf-view-set-slice-from-bounding-box
    "s p" 'pdf-view-set-slice-from-bounding-box
    "C-c g" #'(lambda () (interactive) (pdf-view-redisplay t))
    "C-c C-a d" 'pdf-annot-delete))



(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode -1)))

(general-def image-mode-map
  "<" nil
  ">" nil
  "< l" 'image-bol
  "> l" 'image-eol
  "< b" 'image-bob
  "> b" 'image-eob

  "P" 'image-transform-fit-to-window
  "W" 'image-transform-fit-to-width
  "H" 'image-transform-fit-to-height

  "R" 'image-rotate)
