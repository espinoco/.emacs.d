(require 'key-chord)

(key-chord-mode 1)

(key-chord-define-global "jj" 'er/expand-region)

(key-chord-define-global ",." 'eshell)

(key-chord-define-global "jk" 'ace-jump-mode-pop-mark)

(add-hook 'eshell-mode-hook
          '(lambda () (key-chord-define eshell-mode-map ",." 'exit-eshell)))

(key-chord-define dired-mode-map "ep" 'export-latex-to-pdf)

(require 'message)

(key-chord-define message-mode-map "jq" 'ispell-message)

(setq my-timer (run-with-idle-timer 0.3 'repeat 'my-enable-chords))

(provide 'init-key-chord)
