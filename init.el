(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Emacs is powering up...")

(when (version< emacs-version "24.4")
    (error "Emacs requires at least GNU Emacs 24.4, but you're running %s" emacs-version))

(setq load-prefer-newer t)

(defvar emacs-dir (file-name-directory load-file-name)
  "The root dir of Emacs.")

(defvar savefile-dir (expand-file-name "savefile" emacs-dir)
  "This folder stores all the automatically generated save/history-files.")

(defvar elpa-dir (expand-file-name "elpa" emacs-dir)
  "This folder stores all modules installed from elpa.")

(defvar modules-dir (expand-file-name "modules" emacs-dir)
  "This folder stores all modules that will be loaded by Emacs.")

(defvar modules-file (expand-file-name "modules.el" emacs-dir)
  "This file contains a list of modules that will be loaded by Emacs.")

(defvar personal-file (expand-file-name "personal.el" emacs-dir)
  "This directory is for my private configuration.")

(unless (file-exists-p savefile-dir)
  (make-directory savefile-dir))

(let ((default-directory modules-dir))
  (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory elpa-dir))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path (concat emacs-dir "core"))
(add-to-list 'load-path (concat emacs-dir "init"))

(add-to-list 'custom-theme-load-path
             (concat emacs-dir "themes/zenburn-emacs"))

(message "Loading Emacs's core...")

(require 'packages)
(require 'ui)
(require 'core)
(require 'editor)
(require 'global-keybindings)

(when (eq system-type 'darwin)
    (require 'os-x))

(when (file-exists-p modules-file)
  (message "Loading Emacs's modules...")
  (load modules-file))

(when (file-exists-p personal-file)
  (message "Loading personal configuration files...")
  (load personal-file))

(add-hook 'after-init-hook 'welcome-message)
