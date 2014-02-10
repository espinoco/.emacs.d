(add-to-list 'load-path "~/.emacs.d/extensions/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-M-2") 'er/expand-region)

(provide 'init-expand-region)
