(require 'sass-mode)

(autoload 'sass-mode "sass-mode"
  "Major mode for editing sass files" t)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))

(add-hook 'sass-mode-hook 'syntax-color-hex)

(provide 'init-sass-mode)
