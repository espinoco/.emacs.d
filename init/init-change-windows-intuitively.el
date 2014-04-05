(add-to-list 'load-path "~/.emacs.d/extensions/change-windows-intuitively")
(require 'change-windows-intuitively)

(global-set-key (kbd "C-M-j") 'proff-select-window-left)
(global-set-key (kbd "C-M-l") 'proff-select-window-right)
(global-set-key (kbd "C-M-k") 'proff-select-window-down)

(add-hook 'completion-at-point-functions
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'shell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'eshell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'nxml-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(provide 'init-change-windows-intuitively)
