(require 'groovy-mode)

(autoload 'groovy-mode "groovy-mode"
  "Major mode for editing Groovy code." t)

(add-to-list 'auto-mode-alist '("\\.g\\(?:ant\\|roovy\\|radle\\)\\'" . groovy-mode))

(provide 'init-groovy-modes)
