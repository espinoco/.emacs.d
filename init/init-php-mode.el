(add-to-list 'load-path "~/.emacs.d/extensions/php")
(require 'php-mode)
(add-to-list 'auto-mode-alist
     	     '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

(provide 'init-php-mode)
