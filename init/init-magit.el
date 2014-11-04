(require 'magit)

(define-key magit-log-mode-map (kbd "x") 'magit-reset-head-hard)

(define-key magit-mode-map (kbd "SPC") 'ace-jump-char-mode)

(provide 'init-magit)