(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)

(add-to-list 'load-path
             (expand-file-name "/usr/local/Cellar/ledger/3.1/share/emacs/site-lisp/ledger/"))

(add-to-list 'auto-mode-alist '("\\.hledger.journal$" . ledger-mode))

(defun push-ledger-journal-file ()
  (interactive)
  (shell-command "cd ~/Dropbox/hledger ; git add -A ; git commit -m \"Auto push file\" ; git push -u origin master" nil nil))

(add-hook 'kill-emacs-hook 'push-ledger-journal-file)

(provide 'init-ledger)
