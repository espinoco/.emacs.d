(defun open-file-with-external-program (file-name)
  "Opens a file by directly calling the default external program"
  (interactive (list (read-file-name "Open file: ")))
  (shell-command (format "open \"%s\""
                         file-name) nil nil))

(provide 'init-open-with)
