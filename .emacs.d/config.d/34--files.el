;;; -*- lexical-binding: t; -*-

; * keybinds
(general-def-leader
  "f f" 'find-file
  "f F" 'find-file-at-point
  "f R" 'revert-buffer-quick
  "f s" 'save-buffer
  "s"   'save-buffer)

; * dirvish
(use-package dirvish
  :demand t
  :after dired
  :config
  (setq dired-dwim-target t)
  (setq dirvish-reuse-session nil) ;; always delete unused buffers
  (setq dirvish-attributes '(vc-state subtree-state nerd-icons git-msg file-time file-size))
  (setq dirvish-preview-dispatchers '(vc-diff archive image gif pdf))
  (setq dirvish-default-layout '(0 0 0.4))

  (setq dirvish-use-header-line t)
  (setq dirvish-header-line-height 22)
  (setq dirvish-mode-line-height doom-modeline-height)
  (setq dirvish-hide-cursor nil) ;; dont highlight current line

  (general-def 'dirvish-mode-map
    "<tab>" 'dirvish-subtree-toggle
    "/" 'dirvish-narrow
    ")" 'dired-omit-mode
    "p" 'dirvish-layout-toggle

    "i" 'dired-toggle-read-only
    "h" 'dired-up-directory
    "l" 'dired-find-file)

  (add-hook 'dired-mode-hook #'dired-omit-mode)

  (dirvish-override-dired-mode))

; * recentf
(use-package recentf
  :demand t
  :config
  (setq recentf-max-saved-items 300)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/elpa/*"))
  (add-to-list 'recentf-exclude (expand-file-name "/usr/share/emacs/*"))
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*org.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*misc.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*glossar.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*aufgaben.tex")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*aufgaben.pdf")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*mitschrieb.tex")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*mitschrieb.pdf")

  (general-def-leader
    "f r" 'recentf-open)

  (recentf-mode t))

; * bookmark
(use-package bookmark
  :demand t
  :config
  ;; always save bookmarks after changes have been made
  (setq bookmark-save-flag 1)

  (general-def-leader
    "f b" 'bookmark-jump))
