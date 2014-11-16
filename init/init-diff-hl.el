(require 'diff-hl)

(require 'diff-hl-dired)

(add-hook 'java-mode-hook 'turn-on-diff-hl-mode)

(add-hook 'nxml-mode-hook 'turn-on-diff-hl-mode)

(provide 'init-diff-hl)
