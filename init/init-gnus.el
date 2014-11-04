(setq gnus-select-method
    '(nnimap "gmail"
        (nnimap-address "imap.gmail.com")
        (nnimap-server-port 993)
        (nnimap-stream ssl)))

(setq user-mail-address "carloeduardorodriguez@gmail.com")

(setq user-full-name "Carlo Eduardo Rodríguez Espino")

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "carloeduardorodriguez@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(setq gnus-message-archive-group nil)

(setq mm-discouraged-alternatives '("text/html" "text/richtext"))

(setq gnus-always-read-dribble-file t)

(provide 'init-gnus)