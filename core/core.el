;; core.el --- Here are the definitions of most of the added functions

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

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun open-file-with-external-program (arg)
  "Open visited file in default external program.
   When in dired mode, open file under the cursor.
   With a prefix ARG always prompt for command to use."
  (interactive "P")
  (let* ((current-file-name
          (if (eq major-mode 'dired-mode)
              (dired-get-file-for-visit)
            buffer-file-name))
         (open (pcase system-type
                 (`darwin "open")
                 ((or `gnu `gnu/linux `gnu/kfreebsd) "xdg-open")))
         (program (if (or arg (not open))
                      (read-shell-command "Open current file with: ")
                    open)))
    (start-process "open-file-with-external-program" nil program current-file-name)))

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
  (windmove-right)
  (ido-switch-buffer))

(defun switch-to-buffer-other-bottom-window ()
  "Switch to buffer in other window to the bottom"
  (interactive)
  (split-window-below)
  (windmove-down)
  (ido-switch-buffer))

(defun dired-find-file-other-vertical-window ()
  "In Dired, visit this file or directory in another vertical window."
  (interactive)
  (defvar get-filename-on-dired 'dired-copy-filename-as-kill)
  (split-window-right)
  (windmove-right)
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

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))

(defun exit-eshell ()
  "Exits eshell just like executing exit"
  (interactive)
  (insert "exit")
  (eshell-send-input))

(defun insert-and-indent-line-below ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun insert-and-indent-line-above ()
  (interactive)
  (push-mark)
  (let*
      ((ipt (progn (back-to-indentation) (point)))
       (bol (progn (move-beginning-of-line 1) (point)))
       (indent (buffer-substring bol ipt)))
    (newline)
    (previous-line)
    (insert indent)))

(defun copy-line-or-region ()
  "Copy current line, or text selection.
When `universal-argument' is called first, copy whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position))
                        (setq p2 (line-end-position)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-ring-save p1 p2)))

(defun syntax-color-hex ()
    "Syntax color hex color spec such as 「#ff1100」 in current buffer."
    (interactive)
    (font-lock-add-keywords
        nil
    '(("#[abcdef[:digit:]]\\{6\\}"
        (0 (put-text-property
            (match-beginning 0)
            (match-end 0)
            'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

(defun my-enable-chords ()
  (setq input-method-function 'key-chord-input-method))

(defun my-disable-chords ()
  (setq input-method-function nil))

(provide 'core)
