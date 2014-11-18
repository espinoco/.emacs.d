(require 'evil-leader)

(global-evil-leader-mode)

(evil-leader/set-leader ",")

(require 'evil)

(require 'evil-numbers)

(require 'evil-surround)

(evil-mode t)

(global-evil-surround-mode 1)

(setq evilnc-hotkey-comment-operator ",ci")

(require 'evil-nerd-commenter)

(evilnc-default-hotkeys)

(define-key evil-normal-state-map (kbd "s") 'ace-jump-char-mode)

(define-key evil-visual-state-map (kbd "<return>") 'align-regexp)

(global-set-key (kbd "C-c") 'nil)

(defun my-evil-force-normal-state ()
  "Evil force normal state"
  (interactive)
  (ac-stop)
  (evil-force-normal-state)
  )

(global-set-key (kbd "C-c") 'my-evil-force-normal-state)

(define-key evil-normal-state-map (kbd "C-c") 'my-evil-force-normal-state)

(define-key evil-insert-state-map (kbd "C-c") 'my-evil-force-normal-state)

;; (defvar my-mc-evil-previous-state nil)
;; (defun my-mc-evil-switch-to-emacs-state ()
;;   (when (and (bound-and-true-p evil-mode)
;;              (not (eq evil-state 'emacs)))
;;     (setq my-mc-evil-previous-state evil-state)
;;     (evil-emacs-state)))
;; (defun my-mc-evil-back-to-previous-state ()
;;   (when my-mc-evil-previous-state
;;     (unwind-protect
;;         (case my-mc-evil-previous-state
;;           ((normal visual insert) (evil-force-normal-state))
;;           (t (message "Don't know how to handle previous state: %S"
;;                       my-mc-evil-previous-state)))
;;       (setq my-mc-evil-previous-state nil))))
;; (add-hook 'multiple-cursors-mode-enabled-hook
;;           'my-mc-evil-switch-to-emacs-state)
;; (add-hook 'multiple-cursors-mode-disabled-hook
;; (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
;; (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)
;; Don't move back the cursor one position when exiting insert mode
(define-key evil-normal-state-map "m" 'point-to-register)

(define-key evil-normal-state-map "'" 'jump-to-register)

(define-key evil-normal-state-map [escape] 'keyboard-quit)

(define-key evil-visual-state-map [escape] 'keyboard-quit)

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(define-key evil-normal-state-map (kbd "C-y") 'yank)

(evil-leader/set-key
  "f" 'find-file
  "j" 'ido-switch-buffer
  "k" 'kill-buffer
  "," 'evilnc-comment-or-uncomment-lines
  "s" 'magit-status
  "d" 'dired-jump
  "m" 'smex
  "b" 'previous-buffer
  "a" 'org-agenda-list
  "+" 'evil-numbers/inc-at-pt
  "-" 'evil-numbers/dec-at-pt
  )

(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-goto-file)

(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-region)

;; org-mode

(defun evil-org-insert-heading-respect-content ()
  "Insert heading in org-mode with evil"
  (interactive)
  (evil-digit-argument-or-evil-beginning-of-line)
  (org-insert-heading-respect-content)
  (evil-append 1)
  (org-shiftmetadown)
  )

(defun evil-org-insert-heading-above-respect-content ()
  "Insert heading above in org-mode with evil"
  (interactive)
  (evil-digit-argument-or-evil-beginning-of-line)
  (org-insert-heading-respect-content)
  (evil-append 1)
  )
;; (evil-define-key 'normal org-mode-map (kbd "C-<return>") 'evil-org-insert-heading-respect-content)

(define-key org-agenda-mode-map "j" 'evil-next-line)

(define-key org-agenda-mode-map "k" 'evil-previous-line)

(evil-leader/set-key-for-mode 'org-mode "t" 'org-todo)

(evil-leader/set-key-for-mode 'org-mode "o" 'evil-org-insert-heading-respect-content)

(evil-leader/set-key-for-mode 'org-mode "O" 'evil-org-insert-heading-above-respect-content)

(evil-define-key 'normal org-mode-map "gj" 'org-shiftmetadown)

(evil-define-key 'normal org-mode-map "gk" 'org-shiftmetaup)

(evil-define-key 'normal org-mode-map "gl" 'org-shiftmetaright)

(evil-define-key 'normal org-mode-map "gh" 'org-shiftmetaleft)

(evil-define-key 'normal org-mode-map "gd" 'org-deadline)

(evil-define-key 'normal org-mode-map "gs" 'org-schedule)

;; calendar

;; (require 'calendar)

;; (evil-set-initial-state 'calendar-mode 'emacs)

;; (add-hook 'calendar-mode-hook (lambda ()
;;                                 (local-set-key "h" 'calendar-backward-day)
;;                                 (local-set-key "l" 'calendar-forward-day)
;;                                 (local-set-key "k" 'calendar-backward-week)
;;                                 (local-set-key "j" 'calendar-forward-week)
;;                                 ))

(dolist (command '(evil-paste-after evil-paste-before))
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
                                     css-mode
                                     ))
        (let ((mark-even-if-inactive transient-mark-mode))
          (indent-region (region-beginning) (region-end) nil))))))

;; multiple-cursors

(define-key evil-normal-state-map (kbd "C-n") 'mc/mark-next-like-this)

(define-key evil-normal-state-map (kbd "C-p") 'mc/unmark-next-like-this)

(define-key evil-normal-state-map (kbd "C-x") 'mc/skip-to-next-like-this)

;; (evil-define-key 'normal mc/keymap (kbd "C-c") 'mc/keyboard-quit)
;; (evil-define-key 'visual mc/keymap (kbd "C-c") 'mc/keyboard-quit)

;; (define-key mc/keymap (kbd "C-c") 'mc/keyboard-quit)

;; gnus

(define-key message-mode-map (kbd "gs") 'message-send-and-exit)

(provide 'init-evil)
