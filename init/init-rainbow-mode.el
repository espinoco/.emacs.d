(require 'rainbow-mode)

(defun my-turn-on-rainbow-mode ()
  (rainbow-mode 1))

(add-hook 'html-mode-hook 'my-turn-on-rainbow-mode)

(add-hook 'php-mode-hook 'my-turn-on-rainbow-mode)

(add-hook 'sass-mode-hook 'my-turn-on-rainbow-mode)

(add-hook 'emacs-lisp-mode-hook 'my-turn-on-rainbow-mode)

(add-hook 'nxml-mode-hook 'my-turn-on-rainbow-mode)

(add-hook 'java-mode-hook 'my-turn-on-rainbow-mode)

(provide 'init-rainbow-mode)
