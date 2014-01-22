(require 'org)

(defun insert-straight-brackets-in-org-mode()
  "Inserts couple of [ symbols like this: [ ] "
  (interactive)
  (insert "[ ] "))

(define-key org-mode-map (kbd "`") 'insert-straight-brackets-in-org-mode)

(define-key global-map "\C-cn" 'org-capture)
(setq org-agenda-files '("~/Org"))
(define-key global-map "\C-ca" 'org-agenda)

;; Open agenda on start-up
(org-agenda-list)

(provide 'init-org-mode)
