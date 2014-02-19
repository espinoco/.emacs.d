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

;; (add-hook 'kill-emacs-hook (lambda ()
                             ;; (interactive)
                             ;; (shell-command "cd ~/Org" nil nil)
                             ;; (shell-command "git add -A" nil nil)
                             ;; (shell-command (format "git commit -m \"%s Emacs kill push\""
                                                    ;; (shell-command "date" nil nil)) nil nil)
                             ;; (shell-command "git push -u origin master") nil nil))

(defun push-org-notes)

(provide 'init-org-mode)
