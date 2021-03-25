;;; -*- lexical-binding: t; -*-



(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)

  :custom
  (pdf-view-resize-factor 1.1)
  (pdf-view-display-size 'fit-page)
  (pdf-annot-activate-created-annotations t)

  :config
  (pdf-tools-install)

  (add-hook 'pdf-view-mode-hook '(lambda () (display-line-numbers-mode -1)))
  (add-hook 'text-mode-hook 'evil-insert-state)

  (general-def 'normal pdf-view-mode-map
    "=" 'pdf-view-fit-page-to-window)

  (general-def 'visual pdf-view-mode-map :prefix "SPC SPC"
    "w" 'pdf-annot-add-squiggly-markup-annotation
    "h" 'pdf-annot-add-highlight-markup-annotation
    "s" 'pdf-annot-add-strikethrough-markup-annotation
    "u" 'pdf-annot-add-underline-markup-annotation
    "H" 'pdf-annot-add-markup-annotation)

  (general-def 'normal pdf-view-mode-map "SPC" nil)
  (general-def 'normal pdf-view-mode-map :prefix "SPC SPC"
    "t" 'pdf-annot-add-text-annotation
    "d" 'pdf-annot-delete))



(use-package doc-view
  :defer t

  :custom
  (doc-view-continuous t)

  :config
  (defun sk:doc-view-goto-page (count)
    "Goto page COUNT
  if COUNT isn't supplied, go to the last page"
      (interactive "P")
      (if count
          (doc-view-goto-page count)
        (doc-view-last-page)))

  (general-def 'normal doc-view-mode-map "G" 'sk:doc-view-goto-page))
