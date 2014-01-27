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

(global-set-key (kbd "C-,") 'uncomment-comment-region)

(defun insert-semi-colon-with-ñ ()
  (interactive)
  (insert ";"))

(global-set-key (kbd "C-ñ") 'insert-semi-colon-with-ñ)

(defun insert-couple-parentesis()
  "Inserts single parentesis easily"
  (interactive)
  (insert "()")
  (backward-char 1))

(global-set-key (kbd "C-8") 'insert-couple-parentesis)

(defun insert-couple-of-straight-brackets()
  "Inserts couple of [ symbols like this: []"
  (interactive)
  (insert "[]"))

(global-set-key (kbd "`") 'insert-couple-of-straight-brackets)

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

(global-set-key (kbd "´") 'insert-brackets-and-indent)

(defun insert-tilde-symbol()
  "Inserts tilde symbol"
  (interactive)
  (insert "~"))

(global-set-key (kbd "C-º") 'insert-tilde-symbol)

;; Disable the bell just when scrolling to limits
(defun no-bell-sound ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char))
    (ding)))

(setq ring-bell-function 'no-bell-sound)

(provide 'init-custom-functions)
