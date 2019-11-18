(defun user/switch-to-init-buffer ()
    "Switch to the all mighty init.el buffer."
    (interactive)
    (find-file (concat user-emacs-directory "init.el")))

(defun user/switch-to-user-buffer ()
    "Switch to the user.el buffer in elisp directory."
    (interactive)
    (find-file (expand-file-name "user.el" elisp-directory)))

(defun user/switch-to-local-buffer ()
    "Switch to the local.el buffer in elisp directory."
    (interactive)
    (find-file (expand-file-name "local.el" elisp-directory)))

(defun user/switch-to-previous-buffer ()
    "Switch to previous buffer."
    (interactive)
    (previous-buffer))

(defun user/dos2unix ()
    "Replace all DOS carriage returns (^M) with Unix line feeds in a current buffer."
    (interactive)
    (set-buffer-file-coding-system 'unix 't))

(defun user/prettier-eslint ()
    "Format current file with eslint."
    (interactive)
    (let ((root (locate-dominating-file buffer-file-name "node_modules")))
        (if root
            (let ((prettier-binary (concat root "node_modules/.bin/prettier-eslint")))
                (progn
                    (call-process prettier-binary nil "*Prettier-ESLint Errors*" nil buffer-file-name "--write")
                    (revert-buffer t t t))))))

(defun user/capitalize-words-in-string (s)
    "Convert 'under score' string S to 'Under Score' string."
    (mapconcat 'identity (mapcar
                             '(lambda (word) (capitalize (downcase word)))
                             (split-string s " ")) " "))

(defun user/capitalize-words (start end)
    "Capitalize the first letter of every word in a region."
    (interactive "r")
    (if (use-region-p)
        (let ((regionp (buffer-substring start end)))
            (progn
                (kill-region start end)
                (insert (user/capitalize-words-in-string regionp))))))

;; retrieved from https://www.emacswiki.org/emacs/FlySpell
;; For spelling the words are distinguished more skilfully, e.g., "GoodBadType" → "Good", "Bad", and "Type".

(defun user/ispell-looking-at (regexp &optional offset)
  (let ((pos (+ (or offset 0) (point))))
    (when (and (>= pos (point-min)) (< pos (point-max)))
      (string-match regexp (string (char-after pos))))))

(defun user/ispell-forward (&optional backward)
  (let ((ispell-casechars (ispell-get-casechars))
        (ispell-otherchars (ispell-get-otherchars))
        (ispell-many-otherchars-p (ispell-get-many-otherchars-p))
        (offset (if backward -1 0))
        (dir (if backward -1 1))
        (continue t))
    (if subword-mode (subword-forward dir) (forward-word dir))
    (while (and continue
                (not (string= "" ispell-otherchars))
                (user/ispell-looking-at ispell-otherchars offset)
                (user/ispell-looking-at ispell-casechars (+ dir offset)))
      (if subword-mode (subword-forward dir) (forward-word dir))
      (setq continue ispell-many-otherchars-p))))
(defun my-backward () (user/ispell-forward t))

(defun user/ispell-get-word (orig-fun &optional following extra-otherchars)
    (if (not subword-mode)
        (funcall orig-fun following extra-otherchars)
        (if following (user/ispell-forward) (if (not (eobp)) (forward-char)))
        (let* ((beg (progn (my-backward) (point-marker)))
                  (end (progn (user/ispell-forward) (point-marker)))
                  (word (buffer-substring-no-properties beg end)))
            (list word beg end))))

(if (or
        (string-equal system-type "windows-nt")
        (string-equal system-type "ms-dos")
        (string-equal system-type "cygwin"))
    (progn
        (add-hook 'prog-mode-hook
            (lambda () (subword-mode 1)))
        (advice-add #'ispell-get-word :around #'user/ispell-get-word)))

;; end of retrieved from https://www.emacswiki.org/emacs/FlySpell

(defun user/epa-decrypt-region (start end)
  "Decrypt the current region between START and END and copy the
   contents to clipboard. Clipboard contents will be cleared after
   10 seconds. Only works in unix-like systems.

Be careful about using this command in Lisp programs!
Since this function operates on regions, it does some tricks such
as coding-system detection and unibyte/multibyte conversion.  If
you are sure how the data in the region should be treated, you
should consider using the string based counterpart
`epg-decrypt-string', or the file based counterpart
`epg-decrypt-file' instead.

For example:

\(let ((context (epg-make-context \\='OpenPGP)))
  (decode-coding-string
    (epg-decrypt-string context (buffer-substring start end))
    \\='utf-8))"
  (interactive "r")
  (save-excursion
    (let ((context (epg-make-context epa-protocol))
	  plain)
      (epg-context-set-passphrase-callback context
					   #'epa-passphrase-callback-function)
      (epg-context-set-progress-callback context
					 (cons
					  #'epa-progress-callback-function
					  "Decrypting..."))
      (setf (epg-context-pinentry-mode context) epa-pinentry-mode)
      (message "Decrypting...")
      (condition-case error
	  (setq plain (epg-decrypt-string context (buffer-substring start end)))
	(error
	 (epa-display-error context)
	 (signal (car error) (cdr error))))
      (message "Decrypting...done")
      (setq plain (epa--decode-coding-string
		   plain
		   (or coding-system-for-read
		       (get-text-property start 'epa-coding-system-used)
		       'undecided)))
        (kill-new plain)
        (call-process-shell-command "sleep 15 && pbcopy < /dev/null &" nil 0))))

(defun user/yafolding-go-parent-element ()
    "Jump to parent code element."
    (interactive)
    (progn
        (yafolding-go-parent-element)
        (evil-first-non-blank)))

(defvar user-command-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "d t u") #'user/dos2unix)
    (define-key map (kbd "s c w") #'user/capitalize-words)
    (define-key map (kbd "e d r") #'user/epa-decrypt-region)
    map)
  "Keymap for User commands.")

(defun user/eshell-jump-to-prompt ()
  "In normal state will automatically jump to the eshell prompt"
  (interactive)
  (progn
    (evil-goto-line)
    (evil-end-of-line)
    (evil-append 0)))

(defun user/nvm-use-project ()
  "`nvm-use' on project level .nvmrc file if exists."
  (interactive)
  (let ((nvmrc-project-file-path (concat (projectile-project-root) ".nvmrc")))
    (if (file-exists-p nvmrc-project-file-path)
      (nvm-use (s-trim (f-read nvmrc-project-file-path)) nil))))

(defun user/branch-to-kill-ring ()
    "Add current git branch to the `kill-ring'"
    (interactive)
    (let ((branch (magit-get-current-branch)))
      (if branch
        (progn (kill-new branch)
          (message "%s" branch))
        (user-error "There is not current branch"))))

(setq user/projectile-run-eshell-counter 0)

(defun user/projectile-run-eshell (arg)
  "Invoke `eshell' in the project's root.

Switch to the project specific eshell buffer if it already exists. Use universal argument to create new shells"
  (interactive "P")
  (if arg
    (setq user/projectile-run-eshell-counter (+ user/projectile-run-eshell-counter 1)))
  (projectile-with-default-dir (projectile-ensure-project (projectile-project-root))
    (let ((eshell-buffer-name (concat "*eshell " (projectile-project-name) " " (number-to-string user/projectile-run-eshell-counter) "*")))
      (eshell))))

(defun user/kill-all-buffers-except-current ()
  "Kills all user buffers except current one."
  (interactive)
    (mapc 'kill-buffer (cdr (buffer-list (current-buffer)))))

(defun user/save-all-buffers ()
  "Save all buffers by mode."
  (interactive)
  (save-some-buffers 'no-confirm (lambda ()
    (cond
      ((and buffer-file-name (eq major-mode 'tide-mode)))
      ((and buffer-file-name (eq major-mode 'web-mode)))
      ((and buffer-file-name (eq major-mode 'js2-mode)))
      ((and buffer-file-name (derived-mode-p 'org-mode)))
      ((and buffer-file-name (equal buffer-file-name abbrev-file-name)))))))

(defun user/switch-to-scratch-file-buffer ()
    "Switch to `scratch' file buffer."
    (interactive)
    (find-file "~/scratch"))

(provide 'user)
