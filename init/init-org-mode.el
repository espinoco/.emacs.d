(require 'org)

(defun insert-straight-brackets-in-org-mode()
  "Inserts couple of [ symbols like this: [ ] "
  (interactive)
  (insert "[ ] "))

(define-key org-mode-map (kbd "`") 'insert-straight-brackets-in-org-mode)

(define-key global-map "\C-cn" 'org-capture)
(setq org-agenda-files '("~/Org"))
(define-key global-map "\C-ca" 'org-agenda)

(add-hook 'org-mode-hook (lambda ()
                           (local-set-key (kbd "C-'") 'undo)))

;; I still don't know why, but I got to use this to use org agenda
(org-agenda-list)

;; Last command opens default empty buffer so to have a clean window
;; layout at start-up I close other windows.
(delete-other-windows)

(provide 'init-org-mode)
