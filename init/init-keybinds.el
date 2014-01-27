;; Mark-work instead of M-@, since spanish MBP keyboard do not allows it
(global-set-key (kbd "C-M-2") 'mark-word)

(global-set-key (kbd "C-'") 'undo)

(global-set-key (kbd "C-c i") 'ispell)

(global-set-key (kbd "C-c w") 'ispell-word)

(global-set-key (kbd "C-c s") 'shell)

(provide 'init-keybinds)
