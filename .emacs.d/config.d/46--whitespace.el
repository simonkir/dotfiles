;;; -*- lexical-binding: t; -*-

; * indentation settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(general-def "M-SPC" 'delete-horizontal-space)

; * whitespace
(use-package whitespace
  :demand t
  :config
  (setq whitespace-style '(trailing indentation space-before-tab space-after-tab))
  (setq whitespace-action '(auto-cleanup warn-if-read-only))

  (global-whitespace-mode))
