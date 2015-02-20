(setq mac-command-modifier 'control)

(require 'init-exec-path-from-shell)

(defun mac-copy ()
  (shell-command-to-string "pbpaste"))

(defun mac-paste (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun set-mac-paste-and-copy ()
  "Sets mac functions for copy and paste inside terminal"
  (setq interprogram-cut-function 'mac-paste)
  (setq interprogram-paste-function 'mac-copy))

(if window-system
    (message "Using window system")
  (set-mac-paste-and-copy))

(provide 'os-x)
