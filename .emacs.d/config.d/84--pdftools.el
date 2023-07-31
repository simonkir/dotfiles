;;; -*- lexical-binding: t; -*-



(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq pdf-view-resize-factor 1.1)
  (setq pdf-annot-activate-created-annotations t)
  (setq pdf-view-midnight-invert nil)

  (add-hook 'pdf-view-mode-hook #'(lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-view-auto-slice-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-annot-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-isearch-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-outline-minor-mode)
  (add-hook 'pdf-view-mode-hook #'sk:pdf-view-auto-fit-to-window-minor-mode)



  (defun sk:pdf-view-fit-to-window ()
    "fits pdf into window (automatically detect if fit-height or fit-width should be used)"
    (interactive)
    (let* ((pdf-width (car (pdf-view-image-size t)))
           (pdf-height (cdr (pdf-view-image-size t)))
           (pdf-aspect-ratio (/ (* 1.0 pdf-width) pdf-height))
           (window-width (window-pixel-width))
           (window-height (window-pixel-height))
           (window-aspect-ratio (/ (* 1.0 window-width) window-height)))
      (if (> pdf-aspect-ratio window-aspect-ratio)
          (pdf-view-fit-width-to-window)
        (pdf-view-fit-height-to-window))))

  (define-minor-mode sk:pdf-view-auto-fit-to-window-minor-mode
    "automatically fit viewed pages to the current window, so that the whole page is always visible"
    :lighter " "
    (if sk:pdf-view-auto-fit-to-window-minor-mode
        (add-hook 'pdf-view-after-change-page-hook #'sk:pdf-view-fit-to-window nil 'local)
      (remove-hook 'pdf-view-after-change-page-hook #'sk:pdf-view-fit-to-window 'local)))



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

    "=" 'sk:pdf-view-fit-to-window
    "C-c g" #'(lambda () (interactive) (pdf-view-redisplay t))
    "C-c C-r s" 'pdf-view-auto-slice-minor-mode
    "C-C C-r z" 'sk:pdf-view-auto-fit-to-window-minor-mode
    "C-c C-a d" 'pdf-annot-delete))



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
