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
                    :background "#f2777a"
                    :foreground "#f2777a")

(set-face-attribute 'diff-hl-change nil
                    :background "#6699cc"
                    :foreground "#6699cc")

(set-face-attribute 'diff-hl-insert nil
                    :background "#99cc99"
                    :foreground "#99cc99")

(provide 'init-diff-hl)
