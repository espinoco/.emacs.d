(defun uncomment-comment-region ()
  "If region is set, [un]comments it. Otherwise [un]comments current line."
  (interactive)
  (if (eq mark-active nil)
      (progn
	(beginning-of-line 1)
	(set-mark (point))
	(forward-line)
	(comment-dwim nil))
    (comment-dwim nil))
  (deactivate-mark))

(defun insert-semi-colon-with-ñ ()
  (interactive)
  (insert ";"))

(defun insert-ñ ()
  (interactive)
  (insert "ñ"))

(defun insert-couple-parentesis()
  "Inserts single parentesis easily"
  (interactive)
  (insert "()")
  (backward-char 1))

(defun insert-couple-of-straight-brackets()
  "Inserts couple of [ symbols like this: []"
  (interactive)
  (insert "[]"))

(defun insert-brackets-and-indent ()
  (interactive)
  (insert "{")
  (let ((pps (syntax-ppss)))
    (when (and (eolp) (not (or (nth 3 pps) (nth 4 pps))))
      (indent-for-tab-command)
      (insert "\n\n}")
      (indent-for-tab-command)
      (forward-line -1)
      (indent-for-tab-command))))

(defun insert-tilde-symbol()
  "Inserts tilde symbol"
  (interactive)
  (insert "~"))

;; Disable the bell just when scrolling to limits
(defun no-bell-sound ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char))
    (ding)))

(setq ring-bell-function 'no-bell-sound)

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun open-file-with-external-program ()
  "Opens a file by directly calling the default external program"
  (interactive)
  (defvar get-filename-on-dired 'dired-copy-filename-as-kill)
  (shell-command (format "open \"%s\""
                         (funcall get-filename-on-dired))))

(defun export-latex-to-pdf ()
  "Exports latex file to pdf with pdflatex"
  (interactive)
  (defvar get-filename-on-dired 'dired-copy-filename-as-kill)
  (shell-command (format "pdflatex \"%s\""
                         (funcall get-filename-on-dired))))

(defun switch-to-buffer-other-side-window ()
  "Switch to buffer in other window to the side"
  (interactive)
  (split-window-right)
  (proff-select-window-right)
  (ido-switch-buffer))

(defun switch-to-buffer-other-bottom-window ()
  "Switch to buffer in other window to the bottom"
  (interactive)
  (split-window-below)
  (proff-select-window-down)
  (ido-switch-buffer))

(defun insert-equal-symbol ()
  "Inserts symbol = "
  (interactive)
  (insert "="))

(defun dired-find-file-other-vertical-window ()
  "In Dired, visit this file or directory in another vertical window."
  (interactive)
  (defvar get-filename-on-dired 'dired-copy-filename-as-kill)
  (split-window-right)
  (proff-select-window-right)
  (find-file (funcall get-filename-on-dired)))

(defun dired-copy-path-file-as-kill ()
  "Copy path of marked (or at point) files and folders."
  (interactive)
  (setq current-prefix-arg '(0))
  (call-interactively 'dired-copy-filename-as-kill))

(defun dired-zip-compress-uncompress ()
  "Compress/Uncompress file or directory at point with zip format."
  (interactive)
  (defvar get-filename-on-dired 'dired-copy-filename-as-kill)
  (if (string= (file-name-extension (funcall get-filename-on-dired)) "zip")
      (call-process-shell-command (format "unzip \"%s\""
                                          (funcall get-filename-on-dired))
                                  nil "*Shell Command Output*" t)
    (call-process-shell-command (format "zip -r -X \"%s.zip\" \"%s\""
                                        (funcall get-filename-on-dired)
                                        (funcall get-filename-on-dired))
                                nil "*Shell Command Output*" t))
  (message (format "%s compressed/uncompressed"
                   (funcall get-filename-on-dired))))

(defun kill-gpg-buffers ()
  "Kills gpg buffers"
  (interactive)
  (kill-matching-buffers ".*\.gpg$"))

(provide 'init-custom-functions)
