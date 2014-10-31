(global-set-key (kbd "C--") 'undo)

(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(global-set-key (kbd "M-s") 'backward-word)

(define-key dired-mode-map (kbd "M-s") 'backward-word)

(add-hook 'eshell-mode-hook (lambda ()
                             (local-set-key (kbd "M-s") 'backward-word)))

(global-set-key (kbd "C-,") 'uncomment-comment-region)

(global-set-key (kbd "´") 'insert-brackets-and-indent)

(global-set-key [\M-f2] 'apply-macro-to-region-lines)

(global-set-key [f2] 'kmacro-end-and-call-macro)

(global-set-key [f3] 'kmacro-start-macro)

(global-set-key [f4] 'kmacro-end-macro)

(global-set-key (kbd "<M-backspace>") 'tinyeat-backward-preserve)

(global-set-key "\M-d" 'tinyeat-forward-preserve)

(global-set-key (kbd "<S-backspace>") 'tinyeat-delete-whole-word)

(global-set-key (kbd "C-k") 'tinyeat-kill-line)

(global-set-key (kbd "C-S-SPC") 'tinyeat-join-lines)

(global-set-key (kbd "<C-backspace>") (lambda ()
                                        (interactive)
                                        (forward-word 2)
                                        (backward-word)
                                        (tinyeat-delete-whole-word)
                                        (tinyeat-backward-preserve)
                                        (backward-word)))

(define-key dired-mode-map (kbd "o") 'dired-find-file-other-vertical-window)

(define-key dired-mode-map (kbd "W") 'dired-copy-path-file-as-kill)

(define-key dired-mode-map (kbd "Z") 'dired-zip-compress-uncompress)

(define-key dired-mode-map (kbd "f") 'ido-find-file)

(define-key dired-mode-map (kbd "l") 'dired-goto-file)

(define-key dired-mode-map (kbd "Q") 'kill-this-buffer)

(define-key dired-mode-map (kbd "q") 'delete-window)

(define-key dired-mode-map (kbd "c") 'dired-do-query-replace-regexp)

(define-key calendar-mode-map (kbd "q") 'delete-window)

(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'magit)

(define-key magit-log-mode-map (kbd "x") 'magit-reset-head-hard)

(global-set-key (kbd "C-j") 'newline-and-indent)

(require 'org-agenda)

(define-key org-agenda-mode-map (kbd "k") 'org-agenda-previous-line)
(define-key org-agenda-mode-map (kbd "j") 'org-agenda-next-line)
(define-key org-agenda-mode-map (kbd "m") 'org-agenda-switch-to)

(require 'dired)

(define-key dired-mode-map (kbd "-") 'dired-jump)

(global-set-key (kbd "C-o") 'insert-and-indent-line-below)
(global-set-key (kbd "C-S-o") 'insert-and-indent-line-above)

(setq viper-mode nil)
(require 'viper)
(global-set-key (kbd "M-f") 'viper-forward-word)
(global-set-key (kbd "M-s") 'viper-backward-word)
(global-set-key (kbd "M-e") 'viper-end-of-word)
(add-hook 'c-mode-common-hook (lambda ()
                                (local-set-key (kbd "M-e") 'viper-end-of-word)))
(require 'org)
(add-hook 'org-mode-hook (lambda ()
                           (local-set-key (kbd "M-e") 'viper-end-of-word)))

(require 'smartrep)
(global-set-key "\C-l" nil)
(smartrep-define-key
    global-map "C-l" '(("j" . 'mc/mark-next-like-this)
                       ("k" . 'mc/mark-previous-like-this)
                       ("a" . 'mc/mark-all-like-this)
                       ("s" . 'mc/skip-to-next-like-this)))

(require 'evil)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(provide 'init-keybinds)
