(require 'tinyeat)

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

(provide 'init-tiny-tools)