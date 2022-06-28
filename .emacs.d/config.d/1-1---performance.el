;;; -*- lexical-binding: t; -*-



;; some performance improvements found in the doom emacs faq

(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook #'(lambda () (setq gc-cons-threshold 16777216) (setq gc-cons-percentage 0.1)))

(defvar sk:file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook #'(lambda () (setq file-name-handler-alist sk:file-name-handler-alist)))
