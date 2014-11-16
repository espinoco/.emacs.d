(require 'key-chord)

(key-chord-mode 1)

(key-chord-define-global "fj" 'ido-switch-buffer)

(key-chord-define-global "xh" 'mark-whole-buffer)

(key-chord-define-global "cm" 'goto-match-paren)

(key-chord-define-global "jj" 'er/expand-region)

(key-chord-define-global ",." 'eshell)

(key-chord-define-global "qj" 'ispell-word)

(key-chord-define-global "jk" 'ace-jump-mode-pop-mark)

(add-hook 'eshell-mode-hook
          '(lambda () (key-chord-define eshell-mode-map ",." 'exit-eshell)))

(key-chord-define dired-mode-map "ep" 'export-latex-to-pdf)

(require 'message)

(key-chord-define message-mode-map "jq" 'ispell-message)

(provide 'init-key-chord)
