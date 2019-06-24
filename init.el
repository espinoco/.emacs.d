(defvar backups-directory
    (expand-file-name "backups" user-emacs-directory)
    "This folder stores all backup files.")

(defvar persistent-directory
    (expand-file-name "persistent" user-emacs-directory)
    "This folder stores all persistent/history files.")

(defvar elisp-directory
    (expand-file-name "elisp" user-emacs-directory)
    "This folder stores all elisp files.")

(defvar local-elisp-file
    (expand-file-name "local.el" elisp-directory)
    "This file stores all machine local elisp files.")

(defvar font "Hack 14" "Font")

(unless (string-equal system-type "windows-nt")
    (progn
        (load "server")
        (unless (server-running-p)
            (server-start))))

(tool-bar-mode -1)

(scroll-bar-mode -1)

(menu-bar-mode -1)

(delete-selection-mode 1)

(if (window-system)
    (progn
        (global-hl-line-mode 1)
        (load-theme 'material t)))

(if (eq window-system 'ns)
  (progn
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (add-to-list 'default-frame-alist '(ns-appearance . dark))))

(prefer-coding-system 'utf-8-unix)

(x-focus-frame nil)

(setq-default
  inhibit-startup-screen t
  indent-tabs-mode nil
  lisp-indent-function 'common-lisp-indent-function
  lisp-indent-offset 2
  tab-width 2
  c-basic-offset 2
  tab-stop-list (number-sequence 2 50 2)
  eshell-banner-message ""
  epa-pinentry-mode 'loopback)

(setq-default
  backup-directory-alist `((".*" . ,backups-directory))
  auto-save-file-name-transforms `((".*" ,backups-directory t))
  backup-by-copying t
  version-control t
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2)

(setq-default uniquify-buffer-name-style 'post-forward)

(setq-default
  dired-recursive-deletes 'always
  dired-recursive-copies 'always)

(add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)))

(ido-mode t)

(ido-everywhere t)

(unless (file-exists-p persistent-directory)
  (make-directory persistent-directory))

(setq-default
  ido-save-directory-list-file (concat persistent-directory "/ido.last")
  ido-enable-flex-matching t)

(put 'dired-do-copy 'ido 'find-file)

(put 'dired-do-rename 'ido 'find-file)

(show-paren-mode 1)

(set-face-attribute 'default nil :font font)

(set-frame-font font nil t)

(pending-delete-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(winner-mode 1)

(abbrev-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(setq-default delete-by-moving-to-trash t)

(setq-default dabbrev-case-fold-search nil)

(if (memq window-system '(mac ns x))
    (setq-default
        ispell-program-name "aspell"
        ispell-extra-args '("--run-together"))
    (setq-default ispell-program-name "hunspell"))

;; Taken from https://www.emacswiki.org/emacs/ExecuteExternalCommand
;;
;; "Here is some EmacsLisp code that modifies ‘shell-command’ to allow many
;; commands to execute asynchronously (and show the command at the top of
;; the buffer):"
;;
;; Example:

;; (defvar local/qa-token-generated-at nil
;;     "Date in which last QA access token was generated.")

;; (defun local/gen-qa-token ()
;;     "Generate QA access token."
;;     (interactive)
;;     (progn
;;         (setq local/qa-token-generated-at (current-time))
;;         (shell-command "xyz -e qa -v auth get_token &")
;;         ""))

;; (defun local/fetch-qa-token ()
;;     "Fetch QA access token."
;;     (interactive)
;;     (let ((access-token ""))
;;         (progn
;;             (with-current-buffer "*background: zyx -e qa -v auth get_token*"
;;                 (setq access-token
;;                     (nth 1
;;                         (s-match "Access token: \\([0-9A-z]+\\)$"
;;                             (buffer-substring-no-properties (point-max) (point-min))))))
;;             access-token)))

;; (defun local/get-qa-token ()
;;     "Get QA access token."
;;     (if (time-less-p (current-time) (time-add local/qa-token-generated-at (* 60 57)))
;;         (local/fetch-qa-token)
;;         (if (yes-or-no-p "QA access token expired. Generate new one? ")
;;             (local/gen-qa-token))))

;; (defun local/kill-qa-token ()
;;     "Kills QA access token."
;;     (interactive)
;;     (with-current-buffer "*background: xyz -e qa -v auth get_token*"
;;         (kill-new
;;             (nth 1
;;                 (s-match "Access token: \\([0-9A-z]+\\)$"
;;                     (buffer-substring-no-properties (point-max) (point-min)))))))

(defadvice erase-buffer (around erase-buffer-noop)
  "make erase-buffer do nothing")

(defadvice shell-command (around shell-command-unique-buffer activate compile)
  (if (or current-prefix-arg
          (not (string-match "[ \t]*&[ \t]*\\'" command)) ;; background
          (bufferp output-buffer)
          (stringp output-buffer))
      ad-do-it ;; no behavior change

    ;; else we need to set up buffer
    (let* ((command-buffer-name
            (format "*background: %s*"
                    (substring command 0 (match-beginning 0))))
           (command-buffer (get-buffer command-buffer-name)))

      (when command-buffer
        ;; if the buffer exists, reuse it, or rename it if it's still in use
        (cond ((get-buffer-process command-buffer)
               (set-buffer command-buffer)
               (rename-uniquely))
              ('t
               (kill-buffer command-buffer))))
      (setq output-buffer command-buffer-name)

      ;; insert command at top of buffer
      (switch-to-buffer-other-window output-buffer)
      (insert "Running command: " command
              "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n")

      ;; temporarily blow away erase-buffer while doing it, to avoid
      ;; erasing the above
      (ad-activate-regexp "erase-buffer-noop")
      ad-do-it
      (ad-deactivate-regexp "erase-buffer-noop"))))

;; Taken from https://www.emacswiki.org/emacs/ExecuteExternalCommand

(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))

(package-initialize)

;; (package-refresh-contents)

(setq package-list
    '(use-package
         avy
         company
         dashboard
         eldoc
         esh-autosuggest
         eshell-prompt-extras
         evil
         evil-commentary
         evil-escape
         evil-leader
         evil-mc
         flycheck
         exec-path-from-shell
         expand-region
         git-gutter
         highlight-thing
         js2-mode
         js2-refactor
         json-reformat
         nvm
         magit
         markdown-mode
         markdown-toc
         multi-term
         nodejs-repl
         origami
         password-store
         pinentry
         projectile
         restclient
         rjsx-mode
         s
         shell-pop
         tide
         web-mode
         wgrep
         yafolding
         yaml-mode
         yasnippet))

(dolist (package package-list)
  (unless (package-installed-p package)
      (package-install package)))

(use-package shell-pop
  :bind (("C-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(use-package eshell-prompt-extras
  :config
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
      eshell-prompt-function 'epe-theme-lambda)))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  :ensure t)

(use-package multi-term
    :config
    (setq multi-term-program "/bin/bash"))

(use-package pinentry
    :init
    (pinentry-start))

(use-package yaml-mode
    :config
    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package markdown-toc
    :config
    (setq markdown-toc-header-toc-start "<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-or-refresh-toc -->"))

(use-package yafolding
    :config
    (add-hook 'prog-mode-hook
        (lambda () (yafolding-mode))))

(use-package origami
    :config
    (add-hook 'prog-mode-hook
        (lambda () (origami-mode))))

(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "JAVA_HOME")))

(use-package highlight-thing
    :config
    (add-hook 'prog-mode-hook 'highlight-thing-mode)
    (setq
        highlight-thing-exclude-thing-under-point t
        highlight-thing-prefer-active-region t
        highlight-thing-case-sensitive-p t))

(use-package expand-region)

(use-package avy)

(use-package yasnippet
    :config
    (yas-reload-all)
    (add-hook 'prog-mode-hook #'yas-minor-mode)
    (setq hippie-expand-try-functions-list
        '(yas-hippie-try-expand
             try-expand-dabbrev
             try-expand-dabbrev-all-buffers
             try-expand-dabbrev-from-kill
             try-expand-all-abbrevs
             try-complete-file-name-partially
             try-complete-lisp-symbol-partially
             try-complete-lisp-symbol)))

(use-package git-gutter
    :config
    (add-hook 'yaml-mode-hook 'git-gutter-mode)
    (add-hook 'prog-mode-hook 'git-gutter-mode))

(use-package password-store)

(use-package projectile
    :config
    (setq
        projectile-indexing-method 'alien
        projectile-use-git-grep t)
    (projectile-register-project-type 'npm '("package.json")
        :compile "npm install"
        :test "npm test"
        :run "npm start"
        :src-dir "src"
        :test-dir "test"
        :test-suffix ".test"))

(use-package dashboard
    :init
    (setq
        dashboard-banner-logo-title ""
        dashboard-startup-banner nil
        dashboard-items '((recents  . 5)
                             (projects . 5)
                             (bookmarks . 5)
                             (agenda . 5)
                             (registers . 5)))
    :config
    (dashboard-setup-startup-hook))

(use-package magit)

(use-package js2-mode
    :config
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    :init
    (setq js2-strict-missing-semi-warning t))

(use-package rjsx-mode
    :config
    (add-to-list 'auto-mode-alist '("src\\/.*\\.js\\'" . rjsx-mode))
    :init
    (with-eval-after-load 'rjsx-mode
        (define-key rjsx-mode-map (kbd "C-d") nil)))

(use-package js2-refactor
    :requires (js2-mode rjsx-mode)
    :config
    (add-hook 'js2-mode-hook #'js2-refactor-mode)
    (add-hook 'rjsx-mode-hook #'js2-refactor-mode)
    :init
    (js2r-add-keybindings-with-prefix "C-c C-j"))

(use-package nvm)

(use-package nodejs-repl
    :requires (js2-mode)
    :config
    (add-hook 'js2-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-send-line)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-i") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl))))

(use-package restclient)

(use-package user
    :requires (magit nvm projectile s)
    :load-path elisp-directory)

(use-package flycheck)

(use-package eldoc)

(use-package company)

(use-package web-mode)

(use-package tide
  :requires (company eldoc flycheck web-mode)
  :init
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (evil-local-set-key 'normal (kbd "gf") 'tide-jump-to-definition)
    (evil-local-set-key 'normal (kbd "gb") 'tide-jump-back)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  ;; TSX
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
    (lambda ()
      (when (string-equal "tsx" (file-name-extension buffer-file-name))
        (setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  ;; JavaScript
  (defun setup-tide-mode-for-js ()
    (interactive)
    (tide-setup))
  (add-hook 'js2-mode-hook #'setup-tide-mode-for-js)
  ;; JSX
  ;; NOTE: js2 is also active on rjsx buffers, may not be required to activate
  ;; twice
  ;; (add-hook 'rjsx-mode-hook
  ;;   (lambda ()
  ;;     (setup-tide-mode-for-js)))
  :config
  (setq company-tooltip-align-annotations t))

(use-package eshell
    :requires (user)
    :init
    (add-hook 'eshell-mode-hook
        (lambda ()
          (evil-local-set-key 'normal (kbd "i") 'user/eshell-jump-to-prompt)
          (semantic-mode -1)
          (hl-line-mode -1)
          (user/nvm-use-project)))
    (add-hook 'eshell-directory-change-hook
        (lambda () (user/nvm-use-project)))
    :config
    (setq eshell-visual-subcommands '(("git" "log" "diff" "show"))))

(use-package evil-leader
    :requires (avy git-gutter magit user yasnippet)
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
        "ac" 'avy-goto-char
        "a2" 'avy-goto-char-2
        "s" 'avy-goto-char-timer
        "al" 'avy-goto-line
        "aw" 'avy-goto-word-1
        "bb" 'ido-switch-buffer
        "bp" 'user/switch-to-previous-buffer
        "bh" 'previous-buffer
        "bl" 'next-buffer
        "bs" 'user/switch-to-scratch-buffer
        "bk" 'kill-buffer
        "br" 'revert-buffer
        "fs" 'save-buffer
        "ff" 'find-file
        "fj" 'dired-jump
        "fei" 'user/switch-to-init-buffer
        "feu" 'user/switch-to-user-buffer
        "fel" 'user/switch-to-local-buffer
        "gs" 'magit-status
        "gg" 'vc-git-grep
        "ghj" 'git-gutter:next-hunk
        "ghk" 'git-gutter:previous-hunk
        "ghs" 'git-gutter:stage-hunk
        "ghr" 'git-gutter:revert-hunk
        "ghr" 'git-gutter:revert-hunk
        "ghp" 'git-gutter:popup-hunk
        "ghm" 'git-gutter:mark-hunk
        "ghe" 'git-gutter:end-of-hunk
        "ghd" 'git-gutter:set-start-revision
        "hv" 'describe-variable
        "hk" 'describe-key
        "hf" 'describe-function
        "iw" 'ispell-word
        "ib" 'ispell
        "p" 'projectile-command-map
        "p'" 'user/projectile-run-eshell
        "v" 'er/expand-region
        "ws" 'split-window-below
        "wv" 'split-window-right
        "wu" 'winner-undo
        "wr" 'winner-redo
        "wd" 'delete-window
        "wo" 'delete-other-windows
        "wk" 'windmove-up
        "wj" 'windmove-down
        "wh" 'windmove-left
        "wl" 'windmove-right
        "wfc" 'make-frame-command
        "wfo" 'other-frame
        "wfq" 'delete-frame
        "yc" 'yas-new-snippet
        "yf" 'yas-visit-snippet-file
        "yt" 'yas-tryout-snippet
        "<left>" 'buf-move-left
        "<right>" 'buf-move-right
        "<up>" 'buf-move-up
        "SPC" 'local/npm-test
        "<down>" 'buf-move-down
        "'" 'shell-pop
        "o" user-command-map)
    (evil-leader/set-key-for-mode 'rjsx-mode "mp" 'user/prettier-eslint)
    (evil-leader/set-key-for-mode 'markdown-mode "m" markdown-mode-style-map)
    (evil-leader/set-key-for-mode 'eshell-mode "mh" 'eshell-previous-matching-input)
    (define-key evil-normal-state-map "za" 'origami-toggle-node)
    (define-key evil-normal-state-map "zo" 'origami-show-only-node)
    (define-key evil-normal-state-map "zp" 'user/yafolding-go-parent-element)
    (define-key evil-normal-state-map "zm" 'origami-close-all-nodes)
    (define-key evil-normal-state-map "zyha" 'yafolding-hide-all)
    (define-key evil-normal-state-map "zysa" 'yafolding-show-all)
    (define-key evil-normal-state-map "zyhe" 'yafolding-hide-element)
    (define-key evil-normal-state-map "zyse" 'yafolding-show-element)
    (define-key evil-normal-state-map "zr" 'origami-open-all-nodes))

(use-package evil
    :requires (evil-leader dashboard)
    :config
    (evil-mode 1)
    (define-key evil-insert-state-map (kbd "<tab>") 'hippie-expand)
    (evil-set-initial-state 'dashboard-mode 'emacs))

(use-package evil-mc
    :requires (evil)
    :config
    (global-evil-mc-mode 1))

(use-package wgrep
  :requires (evil)
  :config
  (setq wgrep-auto-save-buffer t)
  (add-hook 'wgrep-setup-hook 'evil-normal-state))

(use-package targets
    :requires (evil)
    :load-path elisp-directory
    :init
    (setq targets-user-text-objects
        '((pipe "|" nil separator)
             (paren "(" ")" pair :more-keys "b")
             (bracket "[" "]" pair :more-keys "r")
             (curly "{" "}" pair :more-keys "c")))
    :config
    (targets-setup t
        :inside-key nil
        :around-key nil
        :remote-key nil))

(use-package evil-escape
    :requires (evil)
    :init
    (setq-default evil-escape-key-sequence "jk")
    (setq-default evil-escape-delay 0.2)
    :config
    (evil-escape-mode 1))

(use-package evil-commentary
    :requires (evil)
    :config
    (evil-commentary-mode))

(when (file-exists-p local-elisp-file)
    (use-package local
        :requires (s user)
        :load-path elisp-directory))

;; TODO
;; https://github.com/mclear-tools/dotemacs/blob/master/config.org#eshell
;; eshell up
;; Protect your Eshell prompt https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Btools/shell#protect-your-eshell-prompt
;; use package move add-hook's to :init not :config
;; choose better yafolding keybindings of find better code folding extension
;; decide if use multi-term
;; use password store for pass management
;; verify pinentry is actually working when signing commit with gpg key
;; code folding between origami and yafolding
;; use user/yafolding-go-parent-element more often
;; use nodejs-repl more often
;; use origami folding when required a quick overview of file
;; use M-x occur more ofthen
;; evil-exchange
;; evil-snipe
;; move-text
;; awesome emacs
;; indium for attach sub process to web browser

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(package-selected-packages
     (quote
       (tide nvm git-timemachine typescript-mode graphql-mode fasd esh-autosuggest shell-pop eshell-prompt-extras scala-mode emmet-mode web-mode pinentry el-mock ert-expectations password-store nodejs-repl yafolding multi-term yaml-mode restclient wgrep origami camelCase-mode string-inflection markdown-toc markdown-mode exec-path-from-shell projectile dashboard evil-mc hydra indium expand-region highlight-thing js2-refactor rjsx-mode json-reformat avy git-gutter magit evil-commentary evil-escape evil-escape-mode evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
