;;; -*- lexical-binding: t; -*-

; * xref
(use-package xref
  :general
  (general-def-leader
    "v ." 'xref-find-definitions-other-window
    "v :" 'xref-find-references))
