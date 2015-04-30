(require 'diff-hl)

(add-hook 'emacs-lisp-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'python-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'java-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'nxml-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'css-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'html-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'c-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'c++-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'latex-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'php-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'fish-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'markdown-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'groovy-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'yaml-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'apache-mode-hook 'turn-on-diff-hl-mode)

(set-face-attribute 'diff-hl-delete nil
                    :background "#dca3a3"
                    :foreground "#dca3a3")

(set-face-attribute 'diff-hl-change nil
                    :background "#94bff3"
                    :foreground "#94bff3")

(set-face-attribute 'diff-hl-insert nil
                    :background "#5f7f5f"
                    :foreground "#5f7f5f")

(provide 'init-diff-hl)
