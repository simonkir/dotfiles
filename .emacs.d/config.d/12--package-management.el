;;; -*- lexical-binding: t; -*-



;; use-package

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages"))
(package-initialize)

(bind-keys :map package-menu-mode-map
  ("U" . package-menu-mark-upgrades))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



(setq use-package-verbose t)
(setq use-package-always-defer t)
(setq use-package-always-ensure t)



;;(use-package general
;;  :demand t)

(use-package bind-key
  :demand t)

(setq sk:leader-map (make-sparse-keymap))
