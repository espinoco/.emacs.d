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
(evil-leader/set-key
  "f" 'find-file
  "b" 'ido-switch-buffer
  "k" 'kill-buffer
  "," 'evilnc-comment-or-uncomment-lines
  "s" 'magit-status
  "d" 'dired-jump
  )
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-goto-file)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-region)
(provide 'init-evil)
