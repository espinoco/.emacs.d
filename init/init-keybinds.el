(global-set-key (kbd "C-'") 'undo)

(global-set-key (kbd "C-c i") 'ispell)

(global-set-key (kbd "C-c w") 'ispell-word)

(global-set-key (kbd "C-c s") 'eshell)

(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(global-set-key (kbd "M-s") 'backward-word)

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

(global-set-key (kbd "C-c m") 'goto-match-paren)

(global-set-key (kbd "C-0") 'insert-equal-symbol)

(provide 'init-keybinds)
