(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank-pop -1)))

(global-set-key (kbd "C-o") 'insert-and-indent-line-below)

(global-set-key (kbd "C-S-o") 'insert-and-indent-line-above)

(setq viper-mode nil)

(require 'viper)

(global-set-key (kbd "M-f") 'viper-forward-word)

(global-set-key (kbd "M-s") 'viper-backward-word)

(global-set-key (kbd "M-e") 'viper-end-of-word)

(require 'smartrep)

(global-set-key "\C-l" nil)

(smartrep-define-key
    global-map "C-l" '(("j" . 'mc/mark-next-like-this)
                       ("k" . 'mc/mark-previous-like-this)
                       ("a" . 'mc/mark-all-like-this)
                       ("s" . 'mc/skip-to-next-like-this)))

(global-set-key "\M- " 'hippie-expand)

(global-set-key (kbd "C-j") 'newline-and-indent)

(provide 'global-keybindings)