;; core.el --- Here are the definitions of most of the added functions

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

(defun welcome-message()
    (message
      (format "Emacs is ready Master %s, Happy Hacking!"
       (user-login-name))))

(defun insertion-insert-numbers-strings (number-string)
  "Handle insertion and new line"
  (insert number-string)
  (newline-and-indent)
  )

(defun insert-numbers-strings (number-of-numbers)
  "Inserts a list of numbers like: one two three etc"
  (interactive "nHow many?: ")
  (setq insert-numbers-strings-count 0)
  (while (< insert-numbers-strings-count number-of-numbers)
    (setq insert-numbers-strings-count (+ insert-numbers-strings-count 1))
    (when (= insert-numbers-strings-count 1)
        (insertion-insert-numbers-strings "One"))
    (when (= insert-numbers-strings-count 2)
        (insertion-insert-numbers-strings "Two"))
    (when (= insert-numbers-strings-count 3)
        (insertion-insert-numbers-strings "Three"))
    (when (= insert-numbers-strings-count 4)
        (insertion-insert-numbers-strings "Four"))
    (when (= insert-numbers-strings-count 5)
        (insertion-insert-numbers-strings "Five"))
    (when (= insert-numbers-strings-count 6)
      (insertion-insert-numbers-strings "Six"))
    (when (= insert-numbers-strings-count 7)
      (insertion-insert-numbers-strings "Seven"))
    (when (= insert-numbers-strings-count 8)
      (insertion-insert-numbers-strings "Eight"))
    (when (= insert-numbers-strings-count 9)
      (insertion-insert-numbers-strings "Nine"))
    (when (= insert-numbers-strings-count 10)
      (insertion-insert-numbers-strings "Ten"))
    (when (= insert-numbers-strings-count 11)
      (insertion-insert-numbers-strings "Eveleen"))
    (when (= insert-numbers-strings-count 12)
      (insertion-insert-numbers-strings "Twelve"))
    (when (= insert-numbers-strings-count 13)
      (insertion-insert-numbers-strings "Thirteen"))
    (when (= insert-numbers-strings-count 14)
      (insertion-insert-numbers-strings "Fourteen"))
    (when (= insert-numbers-strings-count 15)
      (insertion-insert-numbers-strings "Fifteen"))
    (when (= insert-numbers-strings-count 16)
      (insertion-insert-numbers-strings "Sixteen"))
    (when (= insert-numbers-strings-count 17)
      (insertion-insert-numbers-strings "Seventeen"))
    (when (= insert-numbers-strings-count 18)
      (insertion-insert-numbers-strings "Eighteen"))
    (when (= insert-numbers-strings-count 19)
      (insertion-insert-numbers-strings "Nineteen"))
    (when (= insert-numbers-strings-count 20)
      (insertion-insert-numbers-strings "Twenty"))
      )
  )

(provide 'core)
