;;; -*- lexical-binding: t; -*-



(use-package julia-mode
  :general ('(normal visual) 'override "SPC r j" 'run-julia))



(use-package gnuplot)



(use-package glsl-mode
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



(use-package jupyter)
