(setq ls-lisp-use-insert-directory-program nil)

(require 'ls-lisp)

(require 'dired)

(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(define-key dired-mode-map (kbd "-") 'dired-jump)

(define-key dired-mode-map (kbd "o") 'dired-find-file-other-vertical-window)

(define-key dired-mode-map (kbd "W") 'dired-copy-path-file-as-kill)

(define-key dired-mode-map (kbd "Z") 'dired-zip-compress-uncompress)

(define-key dired-mode-map (kbd "f") 'ido-find-file)

(define-key dired-mode-map (kbd "Q") 'kill-this-buffer)

(define-key dired-mode-map (kbd "q") 'delete-window)

(define-key dired-mode-map (kbd "c") 'dired-do-query-replace-regexp)

(define-key dired-mode-map (kbd "SPC") 'ace-jump-char-mode)

(define-key dired-mode-map (kbd "<return>") 'open-file-with-external-program)

(provide 'init-dired)
