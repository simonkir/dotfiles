;;; -*- lexical-binding: t; -*-



; spacing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(general-def '(normal insert) 'override
  "M-SPC" 'delete-horizontal-space)



; buffer handling  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-auto-revert-mode)

(general-def '(normal visual) 'override
  "g r" 'revert-buffer)
