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

(define-key evil-normal-state-map (kbd "gr") 'revert-buffer-no-confirm)

(define-key evil-normal-state-map (kbd "go") 'read-only-mode)

(global-set-key (kbd "C-c") 'nil)

(define-key evil-normal-state-map (kbd "C-e") 'projectile-find-file)

(define-key evil-normal-state-map (kbd "\"") 'browse-kill-ring)

(defun my-evil-force-normal-state ()
  "Evil force normal state"
  (interactive)
  (ac-stop)
  (mc/keyboard-quit)
  (evil-force-normal-state)
  )

(defun my-evil-window-actions ()
  (interactive)
  (set-temporary-overlay-map
   (let ((map (make-sparse-keymap)))
     (define-key map (kbd "q") 'delete-window)
     (define-key map (kbd "o") 'delete-other-windows)
     (define-key map (kbd "s") 'switch-to-buffer-other-bottom-window)
     (define-key map (kbd "v") 'switch-to-buffer-other-side-window)
     (define-key map (kbd "k") 'windmove-up)
     (define-key map (kbd "j") 'windmove-down)
     (define-key map (kbd "h") 'windmove-left)
     (define-key map (kbd "l") 'windmove-right)
     map)))

(global-set-key (kbd "C-c") 'my-evil-force-normal-state)

(global-set-key (kbd "C-s") 'save-buffer)

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
  "l" 'magit-log
  "d" 'dired-jump
  "m" 'smex
  "a" 'org-agenda-list
  "b" 'previous-buffer
  "i" 'ispell-word
  "+" 'evil-numbers/inc-at-pt
  "-" 'evil-numbers/dec-at-pt
  "<left>"  'winner-undo
  "<right>"  'winner-redo
  )

(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-goto-file)

(evil-define-key 'normal dired-mode-map (kbd "p") 'pt-regexp-file-pattern)

(evil-define-key 'normal dired-mode-map (kbd "P") 'pt-regexp)

(evil-define-key 'normal dired-mode-map (kbd "n") 'find-name-dired)

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

(define-key org-agenda-mode-map "w" 'my-org-agenda-write)

(evil-leader/set-key-for-mode 'org-mode "t" 'org-todo)

(evil-leader/set-key-for-mode 'org-mode "o" 'evil-org-insert-heading-respect-content)

(evil-leader/set-key-for-mode 'org-mode "O" 'evil-org-insert-heading-above-respect-content)

(evil-define-key 'normal org-mode-map "gj" 'org-shiftmetadown)

(evil-define-key 'normal org-mode-map "gk" 'org-shiftmetaup)

(evil-define-key 'normal org-mode-map "gl" 'org-shiftmetaright)

(evil-define-key 'normal org-mode-map "gh" 'org-shiftmetaleft)

(evil-define-key 'normal org-mode-map "gd" 'org-deadline)

(evil-define-key 'normal org-mode-map "gs" 'org-schedule)

(evil-define-key 'normal org-mode-map "gt" 'org-set-tags-command)

(evil-define-key 'normal org-mode-map "\C-i" 'org-cycle)

(evil-define-key 'normal org-mode-map "gcr" 'set-runtime)

(evil-define-key 'normal org-mode-map "gcp" 'set-priority)

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
                                     css-mode        python-mode
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

(define-key evil-normal-state-map (kbd "C-j") 'mc/mark-next-like-this)

(define-key evil-normal-state-map (kbd "C-k") 'mc/unmark-next-like-this)

(define-key evil-normal-state-map (kbd "C-n") 'mc/skip-to-next-like-this)

;; gnus

;; (define-key message-mode-map (kbd "gs") 'message-send-and-exit)

;; mml-attach-file

;; magit

(evil-define-key 'normal git-commit-mode-map "gc" 'git-commit-commit)

(evil-define-key 'normal git-commit-mode-map "ga" 'git-commit-abort)

(evil-set-initial-state 'git-commit-mode 'insert)

(define-key magit-mode-map (kbd "C-w") 'my-evil-window-actions)

;; window

(define-key evil-normal-state-map (kbd "C-w") 'my-evil-window-actions)

(define-key org-agenda-mode-map "\C-w" 'my-evil-window-actions)

(define-key calendar-mode-map "\C-w" 'my-evil-window-actions)

;; browse-kill-ring

(define-key browse-kill-ring-mode-map "j" 'browse-kill-ring-forward)

(define-key browse-kill-ring-mode-map "k" 'browse-kill-ring-previous)

(define-key browse-kill-ring-mode-map "/" 'browse-kill-ring-search-forward)

(define-key browse-kill-ring-mode-map "0" 'digit-argument)

(define-key browse-kill-ring-mode-map "1" 'digit-argument)

(define-key browse-kill-ring-mode-map "2" 'digit-argument)

(define-key browse-kill-ring-mode-map "3" 'digit-argument)

(define-key browse-kill-ring-mode-map "4" 'digit-argument)

(define-key browse-kill-ring-mode-map "5" 'digit-argument)

(define-key browse-kill-ring-mode-map "6" 'digit-argument)

(define-key browse-kill-ring-mode-map "7" 'digit-argument)

(define-key browse-kill-ring-mode-map "8" 'digit-argument)

(define-key browse-kill-ring-mode-map "9" 'digit-argument)

;; git-timemachine

(evil-set-initial-state 'git-timemachine-mode 'emacs)

(add-hook 'git-timemachine-mode-hook 'turn-off-evil-mode)

(provide 'init-evil)
