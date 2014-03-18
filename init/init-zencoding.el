(add-to-list 'load-path "~/.emacs.d/extensions/zencoding")
(require 'zencoding-mode)

(add-hook 'sgml-mode-hook 'zencoding-mode)

(define-key html-mode-map (kbd "C-c e") 'zencoding-expand-line)

(provide 'init-zencoding)
