(defun comments-javadoc-return ()
  "Advanced `newline' command for Javadoc multiline comments.
Insert a `*' at the beggining of the new line if inside of a comment."
  (interactive "*")
  (let* ((last (point))
         (is-inside
          (if (search-backward "*/" nil t)
              (search-forward "/*" last t)
            (goto-char last)
            (search-backward "/*" nil t))))
    (goto-char last)
    (if is-inside
        (progn
          (newline-and-indent)
          (insert "* "))
      (newline))))

(add-hook 'java-mode-hook
          (lambda ()
            (local-set-key (kbd "<RET>") 'comments-javadoc-return)))

(add-hook 'java-mode-hook
          (lambda ()
            "Treat Java 1.5 @-style annotations as comments."
            (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
	    (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

(provide 'init-java-customizations)
