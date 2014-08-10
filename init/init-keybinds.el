(global-set-key (kbd "C-'") 'undo)

(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(global-set-key (kbd "M-s") 'backward-word)

(define-key dired-mode-map (kbd "M-s") 'backward-word)

(add-hook 'eshell-mode-hook (lambda ()
                             (local-set-key (kbd "M-s") 'backward-word)))

(global-set-key (kbd "C-2") (lambda ()
                              (interactive)
                              (insert "\"\"")
                              (backward-char)))

(global-set-key (kbd "C-,") 'uncomment-comment-region)

(global-set-key (kbd "ñ") 'insert-semi-colon-with-ñ)

(global-set-key (kbd "C-ñ") 'insert-ñ)

(global-set-key (kbd "C-8") 'insert-couple-parentesis)

(global-set-key (kbd "`") 'insert-couple-of-straight-brackets)

(global-set-key (kbd "´") 'insert-brackets-and-indent)

(global-set-key (kbd "C-º") 'insert-tilde-symbol)

(global-set-key (kbd "C-0") 'insert-equal-symbol)

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

(define-key calendar-mode-map (kbd "q") 'delete-window)

(provide 'init-keybinds)
