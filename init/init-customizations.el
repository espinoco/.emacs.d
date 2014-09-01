(tool-bar-mode -1)

(scroll-bar-mode -1)

(add-to-list 'exec-path "/usr/local/bin")

;; Line numbers
(global-linum-mode t)

(require 'uniquify)

(iswitchb-mode t)

(setq ido-enable-flex-matching t)

(setq ido-everywhere t)

(setq dired-recursive-deletes 'always)

(ido-mode t)

(setq-default indent-tabs-mode nil)

;; Placing all back-up files in one directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq command-line-default-directory "~/Downloads")

(setq x-select-enable-clipboard t)

;; Mac command key to control key
(setq mac-command-modifier 'control)

;; Auto-close paris
(electric-pair-mode 1)

;; Turn on paren match highlighting
(show-paren-mode 1)

;; Default indent
(setq-default c-basic-offset 4)

(set-face-attribute 'default nil :font "Anonymous Pro":height 140)

;; Save the state of Emacs from one session to another
(desktop-save-mode 1)

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

(setq inhibit-startup-echo-area-message (lambda ()
                                          (user-login-name)))

(add-hook 'emacs-startup-hook (lambda ()
                                (message (format "Welcome %s, Happy Hacking!" (user-login-name)))))

(pending-delete-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

(setq-default mode-require-final-newline nil
              cperl-indent-level 4
              tab-width 4
              tab-stop-list (number-sequence 4 120 4))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'before-save-hook 'untabify-buffer)

(add-hook 'kill-emacs-hook (lambda ()
                             (interactive)
                             (kill-gpg-buffers)))

(add-hook 'emacs-startup-hook (lambda ()
                                (org-agenda-list)
                                (delete-other-windows)))

(global-auto-revert-mode t)

(setq auto-revert-interval 1)

(provide 'init-customizations)
