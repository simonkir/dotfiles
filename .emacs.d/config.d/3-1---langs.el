;;; -*- lexical-binding: t; -*-



(use-package julia-mode
  :ensure t
  :defer t
  :general ('(normal visual) 'override "SPC r j" 'run-julia))



(use-package gnuplot
  :ensure t
  :defer t)



(use-package glsl-mode
  :ensure t
  :defer t
  :config
  (defun sk:glsl-compile-file-to-image ()
    (interactive)
    (call-process-shell-command (concat "glslViewer "
                                        (buffer-file-name)
                                        " -w 500 -h 500 -E screenshot,"
                                        (buffer-file-name)
                                        ".png")
                                nil nil))

  (general-def 'normal glsl-mode-map
    "SPC SPC c" 'sk:glsl-compile-file-to-image))



(use-package jupyter
  :ensure t
  :defer t)
