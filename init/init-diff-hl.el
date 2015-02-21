(require 'diff-hl)

(add-hook 'emacs-lisp-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'python-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'java-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'nxml-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'css-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'html-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'java-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'c-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'c++-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'latex-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'php-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'fish-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'markdown-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'groovy-mode-hook 'turn-on-diff-hl-mode)

(set-face-attribute 'diff-hl-delete nil
                    :background "#dc322f"
                    :foreground "#dc322f")

(set-face-attribute 'diff-hl-change nil
                    :background "#268bd2"
                    :foreground "#268bd2")

(set-face-attribute 'diff-hl-insert nil
                    :background "#5f8700"
                    :foreground "#5f8700")

(provide 'init-diff-hl)
