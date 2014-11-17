(defadvice sgml-delete-tag (after reindent-buffer activate)
  (cleanup-buffer))

(add-hook 'html-mode-hook 'syntax-color-hex)

(provide 'init-html)
