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
  (mc/keyboard-quit)
  (evil-force-normal-state)
  )

(global-set-key (kbd "C-c") 'my-evil-force-normal-state)

(define-key evil-normal-state-map (kbd "C-c") 'my-evil-force-normal-state)

(define-key evil-insert-state-map (kbd "C-c") 'my-evil-force-normal-state)

(define-key evil-normal-state-map "m" 'point-to-register)

(define-key evil-normal-state-map "'" 'jump-to-register)

(define-key evil-normal-state-map [escape] 'keyboard-quit)

(define-key evil-visual-state-map [escape] 'keyboard-quit)

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)

(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(evil-leader/set-key
  "f" 'find-file
  "j" 'ido-switch-buffer
  "k" 'kill-buffer
  "s" 'magit-status
  "d" 'dired-jump
  "m" 'smex
  "a" 'org-agenda-list
  "b" 'previous-buffer
  "+" 'evil-numbers/inc-at-pt
  "-" 'evil-numbers/dec-at-pt
  "<left>"  'winner-undo
  "<right>"  'winner-redo
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

(evil-define-key 'normal org-mode-map "\C-i" 'org-cycle)

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

;; calendar

(evil-set-initial-state 'calendar-mode 'emacs)

(define-key calendar-mode-map (kbd "l") 'calendar-forward-day)

(define-key calendar-mode-map (kbd "h") 'calendar-backward-day)

(define-key calendar-mode-map (kbd "j") 'calendar-forward-week)

(define-key calendar-mode-map (kbd "k") 'calendar-backward-week)

(define-key calendar-mode-map (kbd "c") 'calendar-cursor-holidays)

(define-key calendar-mode-map (kbd "s") 'ace-jump-char-mode)

;; multiple-cursors

(define-key evil-normal-state-map (kbd "C-n") 'mc/mark-next-like-this)

(define-key evil-normal-state-map (kbd "C-p") 'mc/unmark-next-like-this)

(define-key evil-normal-state-map (kbd "C-x") 'mc/skip-to-next-like-this)

;; gnus

(define-key message-mode-map (kbd "gs") 'message-send-and-exit)

;; magit

(evil-define-key 'normal git-commit-mode-map "gc" 'git-commit-commit)

(evil-define-key 'normal git-commit-mode-map "ga" 'git-commit-abort)

(evil-set-initial-state 'git-commit-mode 'insert)

(provide 'init-evil)
