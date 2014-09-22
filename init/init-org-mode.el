(add-to-list 'load-path "~/.emacs.d/extensions/org/lisp")
(add-to-list 'load-path "~/.emacs.d/extensions/org/contrib/lisp" t)

(require 'org)

(setq-default major-mode 'org-mode)

(setq org-src-fontify-natively t
      org-log-repeat nil)

(setq org-level-faces '(org-level-1
                        org-level-2
                        org-level-3
                        org-level-7
                        org-level-8
                        org-level-6
                        org-level-4
                        org-level-5))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(add-hook 'org-mode-hook (lambda ()
                           (local-set-key (kbd "C-'") 'undo)
                           (org-indent-mode 1)))

(setq org-agenda-files '("~/Dropbox/Org"))

(define-key global-map "\C-ca" 'org-agenda)

(defun archive-all-done ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

(defun set-runtime (selected-runtime)
  (interactive "sEnter runtime (Quick: A, Medium: B, Long: C, Overlong: D): ")
  (org-beginning-of-line)
  (forward-word)
  (backward-word)
  (insert " ")
  (backward-char)
  (insert (format "[#%s" selected-runtime))
  (backward-char)
  (capitalize-word 1)
  (insert "]")
  (org-beginning-of-line))

(define-key org-mode-map (kbd "C-c r") 'set-runtime)

(defun set-priority (selected-priority)
  (interactive "nEnter priority (Blocker: 1, Critical: 2, Major: 3, Minor: 4, Trivial: 5): ")
  (if (< selected-priority 1) (error "Enter an integer number between 0 and 6")
    (if (> selected-priority 5) (error "Enter an integer number between 0 and 6")
      (search-forward "]")
      (forward-char)
      (insert (format "[#%d] " selected-priority))
      (org-beginning-of-line))))

(define-key org-mode-map (kbd "C-c p") 'set-priority)

(defun insert-straight-brackets-in-org-mode()
  "Inserts couple of [ symbols like this: [ ] "
  (interactive)
  (insert "[ ] "))

(define-key org-mode-map (kbd "`") 'insert-straight-brackets-in-org-mode)

(add-hook 'kill-emacs-hook (lambda ()
                             (interactive)
                             (shell-command "cd ~/Dropbox/Org && git add -A && git commit -m \"Emacs kill push\" && git push -u origin master" nil nil)))

(defun push-org-notes ()
  (interactive)
  (shell-command "cd ~/Dropbox/Org && git add -A && git commit -m \"Emacs manually puched notes\" && git push -u origin master" nil nil))

(setq org-tag-faces
      '(
        ("onhold" . (:foreground "yellow" :weight bold))
        ("next" . (:foreground "green" :weight bold))
        ("someday" . (:foreground "purple" :weight bold))
        ("project" . (:foreground "red" :weight bold))
        ))

(provide 'init-org-mode)
