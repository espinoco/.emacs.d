(require 'ispell)

(setq ispell-program-name "/usr/local/bin/hunspell"
      ispell-really-hunspell t
      ispell-dictionary "english")

(add-to-list 'ispell-local-dictionary-alist
             '("english"
               "[[:alpha:]]"
               "[^[:alpha:]]"
               "[']"
               t
               ("-d" "english")
               nil utf-8))

(add-to-list 'ispell-local-dictionary-alist
             '("spanish"
               "[a-zA-Z\304\326\334\344\366\337\374]"
               "[^a-zA-Z\304\326\334\344\366\337\374]"
               "[']" t ("-C" "-d" "spanish") "~latin1" utf-8))

(defun switch-dictionary ()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "english") "spanish" "english")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>") 'switch-dictionary)

(provide 'init-ispell)
