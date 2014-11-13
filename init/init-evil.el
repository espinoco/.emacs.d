(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(require 'evil)
(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
(require 'evil-surround)
(evil-mode t)
(global-evil-surround-mode 1)
(setq evilnc-hotkey-comment-operator ",,")
(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-char-mode)
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
(define-key evil-normal-state-map (kbd "C-y") 'yank)
(evil-leader/set-key
  "f" 'find-file
  "j" 'ido-switch-buffer
  "k" 'kill-buffer
  "," 'evilnc-comment-or-uncomment-lines
  "s" 'magit-status
  "d" 'dired-jump
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

(evil-leader/set-key-for-mode 'org-mode "t" 'org-todo)
(evil-leader/set-key-for-mode 'org-mode "o" 'evil-org-insert-heading-respect-content)
(evil-leader/set-key-for-mode 'org-mode "O" 'evil-org-insert-heading-above-respect-content)

(evil-define-key 'normal org-mode-map "gj" 'org-shiftmetadown)
(evil-define-key 'normal org-mode-map "gk" 'org-shiftmetaup)
(evil-define-key 'normal org-mode-map "gl" 'org-shiftmetaright)
(evil-define-key 'normal org-mode-map "gh" 'org-shiftmetaleft)

;; calendar

;; (require 'calendar)

;; (evil-set-initial-state 'calendar-mode 'emacs)

;; (add-hook 'calendar-mode-hook (lambda ()
;;                                 (local-set-key "h" 'calendar-backward-day)
;;                                 (local-set-key "l" 'calendar-forward-day)
;;                                 (local-set-key "k" 'calendar-backward-week)
;;                                 (local-set-key "j" 'calendar-forward-week)
;;                                 ))

(provide 'init-evil)
