(add-to-list 'load-path "~/.emacs.d/extensions/zencoding")
(require 'zencoding-mode)

(add-hook 'sgml-mode-hook 'zencoding-mode)

(provide 'init-zencoding)
