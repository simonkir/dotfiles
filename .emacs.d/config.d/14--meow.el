;; -*- lexical-binding: t; -*-



(use-package meow
  :demand t
  :config

  ; general settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq meow-use-cursor-position-hack     t)
  (setq meow-expand-hint-remove-delay     2)
  (setq meow-display-thing-help           nil)
  
  (setq meow-keypad-self-insert-undefined nil)
  (setq meow-keypad-start-keys            nil)
  (setq meow-keypad-ctrl-meta-prefix      nil)
  (setq meow-keypad-meta-prefix           nil)
  (setq meow-keypad-literal-prefix        nil)
  (setq meow-keypad-leader-dispatch       sk:leader-map)
  
  (setq meow-mode-state-list '((vterm-mode . insert)))
  (setq meow-expand-exclude-mode-list nil)



  ; meow-thing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;(meow-thing-register 'latex-align  '(pair ("&") ("&"))                  '(pair ("&") ("&")))
  (meow-thing-register 'quote-gqq    '(pair ("„") ("“"))                  '(pair ("„") ("“")))
  (meow-thing-register 'quote-gq     '(pair ("‚") ("‘"))                  '(pair ("‚") ("‘")))
  (meow-thing-register 'quote-eqq    '(pair ("“") ("”"))                  '(pair ("“") ("”")))
  (meow-thing-register 'quote-eq     '(pair ("‘") ("’"))                  '(pair ("‘") ("’")))
  (meow-thing-register 'latex-round  '(pair ("\\left(") ("\\right)"))     '(pair ("\\left(") ("\\right)")))
  (meow-thing-register 'latex-square '(pair ("\\left[") ("\\right]"))     '(pair ("\\left[") ("\\right]")))
  (meow-thing-register 'latex-curly  '(pair ("\\left\\{") ("\\right\\}")) '(pair ("\\left\\{") ("\\right\\}")))

  (setq meow-char-thing-table
        '((?\( . round)
          (?\) . round)
          (?\[ . square)
          (?\] . square)
          (?{ . curly)
          (?} . curly)
          ;;(?& . latex-align)
          (?r . latex-round)
          (?s . latex-square)
          (?c . latex-curly)
          (?„ . quote-gqq)
          (?‚ . quote-gq)
          (?\“ . quote-eqq)
          (?\‘ . quote-eq)
          (?\" . string)
          (?b . buffer)
          (?p . paragraph)
          (?l . line)))

  ;;(defun sk:meow-surround ()
  ;;  (interactive)
  ;;  (when meow--selection
  ;;    (let ((thing (read-char))
  ;;          (beg (region-beginning))
  ;;          (end (+ 1 (region-end))))
  ;;      (save-excursion
  ;;        (goto-char beg)
  ;;        (insert thing)
  ;;        (goto-char end)
  ;;        (insert thing)))))
  


  ; keybinds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun sk:meow-digit-argument-or-eval ()
    "when there is a region, act like eval, otherwise use digit-argument"
    (interactive)
    (let ((digit (- last-command-event ?0)))
      (if (or (< digit 0) (> digit 9))
          (message "digit not in range (digit = %s)" digit)
        (if meow--selection
            (meow-expand digit)
          (call-interactively 'meow-digit-argument)))))

  (defun sk:toggle-case-after-point ()
    "toggles case of letter after point / below cursor. equivalent to vim ~ key"
    (interactive)
    (let* ((p (point))
           (letter (char-after p))
           (upcased (eq letter (upcase letter)))
           (f (if upcased 'downcase-region 'upcase-region)))
      (funcall f p (+ 1 p))
      (forward-char)))

  (defun sk:yank-after-point ()
    (interactive)
    (save-excursion
      (right-char)
      (yank)))

;;  (defun sk:jump-to-matching-parens ()
;;    (interactive)
;;    (let (method)
;;      (save-excursion
;;        (left-char)
;;        (if (looking-at-p "\\s)")
;;            (setq method 'backward-sexp)
;;          (setq method 'forward-sexp)))
;;      (call-intractively method)))



  (general-def meow-motion-state-keymap
    "j"   'meow-next
    "k"   'meow-prev)

  (general-def meow-normal-state-keymap
    "0" 'sk:meow-digit-argument-or-eval
    "9" 'sk:meow-digit-argument-or-eval
    "8" 'sk:meow-digit-argument-or-eval
    "7" 'sk:meow-digit-argument-or-eval
    "6" 'sk:meow-digit-argument-or-eval
    "5" 'sk:meow-digit-argument-or-eval
    "4" 'sk:meow-digit-argument-or-eval
    "3" 'sk:meow-digit-argument-or-eval
    "2" 'sk:meow-digit-argument-or-eval
    "1" 'sk:meow-digit-argument-or-eval
    "~" 'sk:toggle-case-after-point
    "=" 'indent-region
    "-" 'negative-argument
    "." 'repeat
    "*" 'meow-block
    "<" 'meow-beginning-of-thing
    ">" 'meow-end-of-thing
    ";" 'meow-reverse
    ":" 'recenter-top-bottom 
    ;;"%" 'sk:jump-to-matching-parens
    "a" 'meow-append
    "A" 'meow-bounds-of-thing
    "b" 'meow-back-word
    "B" 'meow-back-symbol
    "c" 'meow-join
    "C" 'beginning-of-line
    "d" 'meow-kill
    "e" 'meow-next-word
    "E" 'meow-next-symbol
    "f" 'meow-find
    "g" nil                             ;; reserved for avy
    "G" 'meow-grab
    "h" 'meow-left
    "H" 'meow-left-expand
    "i" 'meow-insert
    "I" 'meow-inner-of-thing
    "j" 'meow-next
    "J" 'meow-next-expand
    "k" 'meow-prev
    "K" 'meow-prev-expand
    "l" 'meow-right
    "L" 'meow-right-expand
    "m" 'meow-line
    "M" 'meow-goto-line
    "n" 'meow-search
    "o" 'meow-open-below
    "O" 'meow-open-above
    "p" 'sk:yank-after-point
    "P" 'meow-yank
    "r" 'meow-replace
    "R" 'meow-swap-grab
    "s" 'meow-change
    ;;"S" 'sk:meow-surround             ;; todo surround function
    "t" 'meow-till
    "u" 'meow-undo
    "U" 'undo-redo
    "v" 'meow-visit
    "w" 'meow-mark-word
    "W" 'meow-mark-symbol
    "x" 'meow-delete
    "X" 'meow-backward-delete
    "=" 'indent-region
    "y" 'meow-save
    "Y" 'meow-sync-grab
    "z" 'meow-pop-selection
    "<escape>" 'meow-cancel-selection)
    
  (meow-global-mode 1))
  
