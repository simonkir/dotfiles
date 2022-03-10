;;; -*- lexical-binding: t; -*-



(use-package bookmark
  :demand t ;; needed for dashboard
  :hook (after-init . bookmark-save)
  :config
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
  (setq recentf-max-saved-items 100)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/*"))
  (add-to-list 'recentf-exclude (expand-file-name "/usr/share/emacs/*"))
  (recentf-mode t)
  (general-def '(normal visual) 'override
    "SPC f r" 'sk:recentf-find-file)

  (defun sk:recentf-find-file ()
    "Find a recent file using completing-read."
    (interactive)
    (let ((file (completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file)))))
