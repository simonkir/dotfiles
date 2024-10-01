;;; -*- lexical-binding: t; -*-

; * doom-themes
(use-package doom-themes
  :demand t
  :config
  (doom-themes-org-config)
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'(lambda () (load-theme 'doom-palenight t)) -10)
    (load-theme 'doom-palenight t)))

; * transparency
;; initial state
(setq sk:alpha-background 90)
(add-to-list 'default-frame-alist `(alpha-background . ,sk:alpha-background))

(defun sk:toggle-transparent-background ()
  "toggle transparent background"
  (interactive)
  (if (= 100 (frame-parameter nil 'alpha-background))
      (set-frame-parameter nil 'alpha-background sk:alpha-background)
    (set-frame-parameter nil 'alpha-background 100)))

(defun sk:set-alpha-background (alpha)
  "interactiveley reads a new background alpha value"
  (interactive "nnew background alpha value (in %%): ")
  (setq sk:alpha-background alpha)
  (set-frame-parameter nil 'alpha-background sk:alpha-background)
  (message "background alpha value set to %s %%" sk:alpha-background))

(general-def-leader
  "d t" 'sk:toggle-transparent-background
  "d T" 'sk:set-alpha-background)

; * solarie mode
(use-package solaire-mode
  :after doom-themes
  :demand t
  :init
  :config
  (defalias 'solaire-mode-line-face 'mode-line)
  (defalias 'solaire-mode-line-active-face 'mode-line-active)
  (defalias 'solaire-mode-line-inactive-face 'mode-line-inactive)

  (dolist (face '((mode-line . solaire-mode-line-face)
                  (mode-line-active . solaire-mode-line-active-face)
                  (mode-line-inactive . solaire-mode-line-inactive-face)))
    (setq solaire-mode-remap-alist (delete face solaire-mode-remap-alist)))

  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'solaire-global-mode))
  (solaire-global-mode))
