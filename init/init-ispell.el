(setq-default ispell-program-name "/usr/local/bin/hunspell")
(setq ispell-dictionary "english")

;; Add spanish dictionary to the list
(require 'ispell)
(add-to-list 'ispell-local-dictionary-alist
             '("spanish"
               "[a-zA-Z\304\326\334\344\366\337\374]"
               "[^a-zA-Z\304\326\334\344\366\337\374]"
               "[']" t ("-C" "-d" "spanish") "~latin1" iso-8859-1))

(defun switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "spanish") "english" "spanish")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'switch-dictionary)

(provide 'init-ispell)
