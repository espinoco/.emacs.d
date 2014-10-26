;; Dired Jump
(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(provide 'init-dired)
