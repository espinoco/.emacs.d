(define-key dired-mode-map (kbd "M-s") 'backward-word)

(add-hook 'eshell-mode-hook (lambda ()
                             (local-set-key (kbd "M-s") 'backward-word)))

(define-key dired-mode-map (kbd "o") 'dired-find-file-other-vertical-window)

(define-key dired-mode-map (kbd "W") 'dired-copy-path-file-as-kill)

(define-key dired-mode-map (kbd "Z") 'dired-zip-compress-uncompress)

(define-key dired-mode-map (kbd "f") 'ido-find-file)

(define-key dired-mode-map (kbd "l") 'dired-goto-file)

(define-key dired-mode-map (kbd "Q") 'kill-this-buffer)

(define-key dired-mode-map (kbd "q") 'delete-window)

(define-key dired-mode-map (kbd "c") 'dired-do-query-replace-regexp)

(define-key calendar-mode-map (kbd "q") 'delete-window)

(require 'magit)

(define-key magit-log-mode-map (kbd "x") 'magit-reset-head-hard)
(define-key magit-mode-map (kbd "SPC") 'ace-jump-char-mode)

(global-set-key (kbd "C-j") 'newline-and-indent)

(require 'org-agenda)

(define-key org-agenda-mode-map (kbd "k") 'org-agenda-previous-line)
(define-key org-agenda-mode-map (kbd "j") 'org-agenda-next-line)
(define-key org-agenda-mode-map (kbd "m") 'org-agenda-switch-to)

(require 'dired)

(define-key dired-mode-map (kbd "-") 'dired-jump)

(add-hook 'c-mode-common-hook (lambda ()
                                (local-set-key (kbd "M-e") 'viper-end-of-word)))
(require 'org)
(add-hook 'org-mode-hook (lambda ()
                           (local-set-key (kbd "M-e") 'viper-end-of-word)))

(require 'evil)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-char-mode)
(define-key dired-mode-map (kbd "SPC") 'ace-jump-char-mode)
(define-key dired-mode-map (kbd "<return>") 'open-file-with-external-program)
(define-key org-agenda-mode-map (kbd "SPC") 'ace-jump-char-mode)

(provide 'init-keybinds)
