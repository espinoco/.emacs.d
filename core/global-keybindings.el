(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(setq viper-mode nil)

(require 'viper)

(global-set-key "\M- " 'hippie-expand)

(global-set-key (kbd "<return>") 'newline-and-indent)

(provide 'global-keybindings)
