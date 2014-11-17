(require 'php-mode)

(autoload 'php-mode "php-mode"
  "Major mode for editing php code." t)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-hook 'php-mode-hook 'syntax-color-hex)

(provide 'init-php-mode)
