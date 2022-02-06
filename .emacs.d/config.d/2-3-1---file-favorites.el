;;; -*- lexical-binding: t; -*-



(use-package bookmark
  :demand t ;; needed for dashboard
  :hook (after-init . bookmark-save)
  :config
  (general-def 'normal 'override
    "SPC f b" 'ido-bookmark-jump)

  (general-def 'normal 'override :prefix "SPC f B"
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
  (recentf-mode t)
  (general-def 'normal 'override "SPC f r" 'recentf-ido-find-file))
