;;; -*- lexical-binding: t; -*-

; * pdf-tools
(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
; ** general settings
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-resize-factor 1.1)
  (setq pdf-annot-activate-created-annotations t)

; ** active minor-modes
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-view-auto-slice-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-annot-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-isearch-minor-mode)
  (add-hook 'pdf-view-mode-hook #'pdf-outline-minor-mode)

; ** keybinds
  (general-def pdf-view-mode-map
    "J" 'pdf-view-next-page
    "K" 'pdf-view-previous-page
    "M" 'pdf-view-goto-page
    "C-f" 'scroll-up
    "C-b" 'scroll-down
    "j" #'(lambda () (interactive) (pdf-view-next-line-or-next-page 4))
    "k" #'(lambda () (interactive) (pdf-view-previous-line-or-previous-page 4))
    "h" #'(lambda () (interactive) (image-backward-hscroll 10))
    "l" #'(lambda () (interactive) (image-forward-hscroll 10))
    "<up>" 'pdf-view-previous-line-or-previous-page
    "<left>" 'image-backward-hscroll
    "<down>" 'pdf-view-next-line-or-next-page
    "<right>" 'image-forward-hscroll

    "v" 'isearch-forward

    "=" nil
    "C-c C-r C-s" 'pdf-view-auto-slice-minor-mode
    "s a" 'pdf-view-auto-slice-minor-mode
    "s b" 'pdf-view-set-slice-from-bounding-box
    "s p" 'pdf-view-set-slice-from-bounding-box
    "s s" 'pdf-view-set-slice-using-mouse
    "C-c g" #'(lambda () (interactive) (pdf-view-redisplay t))
    "C-c C-a d" 'pdf-annot-delete))

; * image-mode
(add-hook 'image-mode-hook #'(lambda () (display-line-numbers-mode -1)))

(general-def image-mode-map
  "<" nil
  ">" nil
  "< l" 'image-bol
  "> l" 'image-eol
  "< b" 'image-bob
  "> b" 'image-eob

  "H" 'image-transform-fit-to-height
  "P" 'image-transform-fit-to-window
  "W" 'image-transform-fit-to-width
  "=" 'image-transform-reset-to-original

  "R" 'image-rotate)
