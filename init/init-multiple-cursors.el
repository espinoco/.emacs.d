(add-to-list 'load-path "~/.emacs.d/extensions/multiple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
(global-set-key (kbd "C->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-r") 'mc/mark-sgml-tag-pair)
(global-set-key (kbd "C-c l") 'mc/edit-beginnings-of-lines)

(provide 'init-multiple-cursors)
