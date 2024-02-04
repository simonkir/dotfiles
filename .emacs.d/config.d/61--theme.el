;;; -*- lexical-binding: t; -*-



; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package doom-themes
  :demand t
  :config
  (doom-themes-org-config)
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'(lambda () (load-theme 'doom-one t)) -10)
    (load-theme 'doom-one t)))



; solarie mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package solaire-mode
  :after doom-themes
  :demand t
  :init
  :config
  (defalias 'solaire-mode-line-face 'mode-line)
  (defalias 'solaire-mode-line-active-face 'mode-line-active)
  (defalias 'solaire-mode-line-inactive-face 'mode-line-inactive)

  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'solaire-global-mode))
  (solaire-global-mode))
