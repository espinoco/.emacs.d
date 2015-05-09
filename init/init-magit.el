(require 'magit)

(define-key magit-log-mode-map (kbd "x") 'magit-reset-head-hard)

(define-key magit-mode-map (kbd "SPC") 'ace-jump-char-mode)

(add-hook 'git-commit-mode (lambda ()
                             (flyspell-mode t)))

(setq magit-completing-read-function 'magit-ido-completing-read)

(set-face-attribute 'magit-item-highlight nil
                    :background "#393939")

(provide 'init-magit)
