;;; -*- lexical-binding: t; -*-



;; use-package

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
            '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-defer t)
(setq use-package-always-ensure t)



;; general.el

(use-package general
  :demand t)
