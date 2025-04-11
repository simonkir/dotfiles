;;; -*- lexical-binding: t; -*-

; * performance improvements
;; some performance improvements found in the doom emacs faq
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook #'(lambda () (setq gc-cons-threshold 16777216) (setq gc-cons-percentage 0.1)))

(defvar sk:file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook #'(lambda () (setq file-name-handler-alist sk:file-name-handler-alist)))

; * package management
; ** package
(require 'package)
(setq package-enable-at-startup nil)

; ** package-archives
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "packages")))
(package-initialize)

; ** use-package
(setq use-package-verbose t)
(setq use-package-always-defer t)

; * custom
(setq custom-file (expand-file-name (concat user-emacs-directory "custom.el")))
(load custom-file)

; * keybinds / general
;; explanation:
;; general-def-leader binds into sk:leader-map
;;   → leader keybinds are the same for all major-modes
;;   → keybinds accessible by SPC key using meow keypad mode

(use-package general
  :demand t
  :config
  (setq sk:leader-map (make-sparse-keymap))
  (general-create-definer general-def-leader :keymaps 'sk:leader-map)
  (general-def package-menu-mode-map "U" 'package-menu-mark-upgrades))
