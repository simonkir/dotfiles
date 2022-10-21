;;; -*- lexical-binding: t; -*-



; spacing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(blink-cursor-mode -1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(general-def "M-SPC" 'delete-horizontal-space)
