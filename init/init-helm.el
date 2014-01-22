;; Helm (fork of Anything)
(add-to-list 'load-path "~/.emacs.d/extensions/helm")
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)

(provide 'init-helm)
