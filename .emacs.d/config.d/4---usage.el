;;; -*- lexical-binding: t; -*-



(blink-cursor-mode -1)



(defun sk:print-time ()
  (interactive)
  (message "%s" (format-time-string "%a, %d.%m.%Y (KW %W), %H:%M:%S %Z")))



(defun sk:cpwd ()
  "print and copy current working directory to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD default-directory)
  (message "%s" default-directory))



(defun sk:org-insert-weekly-todo-list (count)
  "Insert a calendar week heading in Org-mode."
  (interactive "nheadline count: ")
  (dotimes (week-offset count)
    (let* ((week-time (time-add (current-time) (* 86400 7 week-offset)))
           (calendar-week (format-time-string "%V" week-time))
           (day-of-week (string-to-number (format-time-string "%u")))
           (start-date-time (time-subtract week-time (* 86400 (- day-of-week 1))))
           (end-date-time (time-add start-date-time (* 86400 4)))
           (start-date-string (format-time-string "%d.%m." start-date-time))
           (end-date-string (format-time-string "%d.%m." end-date-time)))
      (insert (format "* KW %s: %s – %s\n\n" calendar-week start-date-string end-date-string)))))



(general-def-leader
  "d c" 'sk:cpwd
  "d t" 'sk:print-time)
