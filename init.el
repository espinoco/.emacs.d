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

(defvar font "Hack 12" "Font")

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

(prefer-coding-system 'utf-8-unix)

(x-focus-frame nil)

(setq-default
  inhibit-startup-screen t
  indent-tabs-mode nil
  lisp-indent-function 'common-lisp-indent-function
  lisp-indent-offset 4
  tab-width 4
  c-basic-offset 4
  tab-stop-list (number-sequence 4 120 4)
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
         dashboard
         evil
         evil-commentary
         evil-escape
         evil-leader
         evil-mc
         exec-path-from-shell
         expand-region
         git-gutter
         highlight-thing
         js2-mode
         js2-refactor
         json-reformat
         magit
         markdown-mode
         markdown-toc
         nodejs-repl
         origami
         projectile
         restclient
         rjsx-mode
         wgrep
         yafolding
         yaml-mode
         yasnippet))

(dolist (package package-list)
  (unless (package-installed-p package)
      (package-install package)))

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
    (exec-path-from-shell-initialize)))

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
    (add-hook 'prog-mode-hook 'git-gutter-mode))

(use-package projectile
    :config
    (setq projectile-indexing-method 'alien)
    (projectile-register-project-type 'npm '("package.json")
        :compile "npm install"
        :test "npm test"
        :run "npm start"
        :src-dir "src"
        :test-dir "test"
        :test-suffix ".test"))

(use-package dashboard
    :config
    (dashboard-setup-startup-hook)
    (setq
        dashboard-banner-logo-title "Welcome Master"
        dashboard-startup-banner 'logo
        dashboard-items '((projects . 5)
                             (recents  . 5)
                             (bookmarks . 5)
                             (agenda . 5)
                             (registers . 5))))

(use-package magit)

(use-package js2-mode
    :config
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

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
    :load-path elisp-directory)

(when (file-exists-p local-elisp-file)
    (use-package local
        :load-path elisp-directory))

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
        "gs" 'magit-status
        "gg" 'vc-git-grep
        "ghj" 'git-gutter:next-hunk
        "ghk" 'git-gutter:previous-hunk
        "ghs" 'git-gutter:stage-hunk
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
        "yc" 'yas-new-snippet
        "yf" 'yas-visit-snippet-file
        "yt" 'yas-tryout-snippet
        "<left>" 'buf-move-left
        "<right>" 'buf-move-right
        "<up>" 'buf-move-up
        "<down>" 'buf-move-down
        "o" user-command-map)
    (evil-leader/set-key-for-mode 'rjsx-mode "mp" 'user/prettier-eslint)
    (evil-leader/set-key-for-mode 'markdown-mode "m" markdown-mode-style-map)
    (define-key evil-normal-state-map "za" 'origami-toggle-node)
    (define-key evil-normal-state-map "zo" 'origami-show-only-node)
    (define-key evil-normal-state-map "zp" 'user/yafolding-go-parent-element)
    (define-key evil-normal-state-map "zm" 'origami-close-all-nodes)
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

;; TODO
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
             (nodejs-repl yafolding multi-term yaml-mode restclient wgrep origami camelCase-mode string-inflection markdown-toc markdown-mode exec-path-from-shell projectile dashboard evil-mc hydra indium expand-region highlight-thing js2-refactor rjsx-mode json-reformat avy git-gutter magit evil-commentary evil-escape evil-escape-mode evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
