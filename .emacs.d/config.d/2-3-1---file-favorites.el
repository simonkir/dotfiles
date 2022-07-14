;;; -*- lexical-binding: t; -*-



(use-package bookmark
  :demand t ;; needed for dashboard
  :config
  (add-hook 'after-init-hook 'bookmark-save)

  (general-def '(normal visual) 'override
    "SPC f b" 'bookmark-jump)

  (general-def '(normal visual) 'override :prefix "SPC f B"
    "B" 'edit-bookmarks
    "d" 'bookmark-delete
    "r" 'bookmark-relocate
    "R" 'bookmark-rename
    "s" 'bookmark-set))



(use-package recentf
  :demand t ;; needed for dashboard
  :config
  (setq recentf-max-saved-items 200)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/*"))
  (add-to-list 'recentf-exclude (expand-file-name "/usr/share/emacs/*"))
  (add-to-list 'recentf-exclude ".*/0---org.org")
  (add-to-list 'recentf-exclude ".*/0---misc.org")
  (add-to-list 'recentf-exclude ".*/0---glossar.org")
  (add-to-list 'recentf-exclude ".*/0---aufgaben.tex")
  (add-to-list 'recentf-exclude ".*/0---aufgaben.pdf")
  (add-to-list 'recentf-exclude ".*/0---mitschrieb.tex")
  (add-to-list 'recentf-exclude ".*/0---mitschrieb.pdf")



  (defun sk:recentf-find-file ()
    "Find a recent file using completing-read."
    (interactive)
    (let ((file (completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  (general-def '(normal visual) 'override
    "SPC f r" 'sk:recentf-find-file)



  (recentf-mode t))
