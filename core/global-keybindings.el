(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(setq viper-mode nil)

(require 'viper)

(global-set-key (kbd "M-f") 'viper-forward-word)

(global-set-key (kbd "M-s") 'viper-backward-word)

(global-set-key (kbd "M-e") 'viper-end-of-word)

(global-set-key "\M- " 'hippie-expand)

(global-set-key (kbd "C-j") 'newline-and-indent)

(provide 'global-keybindings)