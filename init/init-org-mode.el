(require 'org)

(defun insert-straight-brackets-in-org-mode()
  "Inserts couple of [ symbols like this: [ ] "
  (interactive)
  (insert "[ ] "))

(define-key org-mode-map (kbd "`") 'insert-straight-brackets-in-org-mode)

(define-key global-map "\C-cn" 'org-capture)
(setq org-agenda-files '("~/Org"))
(define-key global-map "\C-ca" 'org-agenda)

(setq-default major-mode 'org-mode)

(add-hook 'org-mode-hook (lambda ()
                           (local-set-key (kbd "C-'") 'undo)))

;; I still don't know why, but I got to use this to use org agenda
(org-agenda-list)

;; Last command opens default empty buffer so to have a clean window
;; layout at start-up I close other windows.
(delete-other-windows)

(add-hook 'kill-emacs-hook (lambda ()
                              (interactive)
                              (shell-command "cd ~/Org && git add -A && git commit -m \"Emacs kill push\" && git push -u origin master" nil nil)))

(defun push-org-notes ()
  (interactive)
  (shell-command "cd ~/Org && git add -A && git commit -m \"Emacs manually puched notes\" && git push -u origin master" nil nil))

(defun set-priority (selected-priority)
  (interactive "nEnter priority (Blocker: 1, Critical: 2, Major: 3, Minor: 4, Trivial: 5): ")
  (if (< selected-priority 1) (error "Enter an integer number between 0 and 6")
    (if (> selected-priority 5) (error "Enter an integer number between 0 and 6")
      (search-forward "]")
      (forward-char)
      (insert (format "[#%d] " selected-priority))
      (org-beginning-of-line))))

(define-key org-mode-map (kbd "C-c p") 'set-priority)

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

(setq org-src-fontify-natively t)

(defun archive-all-done ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

(provide 'init-org-mode)
