;; Mark-work instead of M-@, since spanish MBP keyboard do not allows it

(global-set-key (kbd "C-'") 'undo)

(global-set-key (kbd "C-c i") 'ispell)

(global-set-key (kbd "C-c w") 'ispell-word)

(global-set-key (kbd "C-c s") 'shell)

(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(global-set-key (kbd "M-s") 'backward-word)

(global-set-key (kbd "C-2") (lambda ()
                              (interactive)
                              (insert "\"\"")
                              (backward-char)))

(provide 'init-keybinds)
