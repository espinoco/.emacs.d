;; editor.el --- Enhanced core editing experience.

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq mode-require-final-newline nil)

(ido-mode t)

(require 'uniquify)

(setq uniquify-buffer-name-style 'post-forward)

(iswitchb-mode t)

(setq ido-enable-flex-matching t)

(setq ido-everywhere t)

(setq dired-recursive-deletes 'always)

(setq dired-recursive-copies 'always)

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq x-select-enable-clipboard t)

(electric-pair-mode 1)

(show-paren-mode 1)

(setq-default c-basic-offset 4)

(setq default-frame-alist '((font . "Source Code Pro ExtraLight-12")))

(desktop-save-mode 1)

(pending-delete-mode t)

(put 'dired-do-copy 'ido 'find-file)

(put 'dired-create-directory 'ido 'find-file)

(put 'dired-do-rename 'ido 'find-file)

(display-time-mode 1)

(setq display-time-24hr-format t)

(setq shell-file-name "/bin/sh")

;; Yank and indent
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                     clojure-mode    scheme-mode
                                     haskell-mode    ruby-mode
                                     rspec-mode      python-mode
                                     c-mode          c++-mode
                                     objc-mode       latex-mode
                                     plain-tex-mode  web-mode
                                     java-mode       php-mode
                                     html-mode       nxml-mode
                                     css-mode        multi-web-mode
                                     multi-web-global-mode))
        (let ((mark-even-if-inactive transient-mark-mode))
          (indent-region (region-beginning) (region-end) nil))))))

(add-hook 'before-save-hook (lambda ()
                              (interactive)
                              (delete-trailing-whitespace)
                              (untabify-buffer)))

(add-hook 'kill-emacs-hook (lambda ()
                             (interactive)
                             (kill-gpg-buffers)))

(add-hook 'emacs-startup-hook (lambda ()
                                (org-agenda-list)
                                (delete-other-windows)))

(require 'magit)

(add-hook 'git-commit-mode (lambda ()
                             (flyspell-mode t)))

(add-hook 'post-command-hook 'my-disable-chords)

(setq my-timer (run-with-idle-timer 0.3 'repeat 'my-enable-chords))

(setq inhibit-startup-echo-area-message (lambda ()
                                          (user-login-name)))

(add-hook 'emacs-startup-hook (lambda ()
                                (message (format "Emacs is ready Master %s, Happy Hacking!" (user-login-name)))))

(setq-default tab-stop-list (number-sequence 4 120 4))

(setq cperl-indent-level 4)

;; (add-hook 'php-mode-hook 'syntax-color-hex)
;; (add-hook 'html-mode-hook 'syntax-color-hex)
;; (add-hook 'sass-mode-hook 'syntax-color-hex)

(add-to-list 'exec-path "/usr/local/bin")

(setenv "PATH" (concat (getenv "PATH") ":/bin"))

(setq exec-path (append exec-path '("/bin")))


(add-hook 'c-mode-common-hook (lambda ()
                               (local-set-key (kbd "M-e") 'viper-end-of-word)))


(setq ring-bell-function 'no-bell-sound)

(setq ring-bell-function 'ignore)

(provide 'editor)
