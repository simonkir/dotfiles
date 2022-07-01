;;; -*- lexical-binding: t; -*-



(use-package doom-themes
  :demand t
  :config
  (doom-themes-org-config)
  (load-theme 'doom-one t)

  (general-def 'normal 'override
    "SPC d t" '(lambda () (interactive) (load-theme 'doom-one t))
    "SPC d T" '(lambda () (interactive) (load-theme 'doom-one-light t))))
