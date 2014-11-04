(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Emacs is powering up...")

(when (version< emacs-version "24.4")
    (error "Emacs requires at least GNU Emacs 24.4, but you're running %s" emacs-version))

;; Always load newest byte code
(setq load-prefer-newer t)

(defvar emacs-dir (file-name-directory load-file-name)
  "The root dir of Emacs.")

(defvar modules-dir (expand-file-name "modules" emacs-dir)
  "This directory houses all of the built-in Emacs modules.")

(defvar core-dir (expand-file-name "core" emacs-dir)
  "The home of Emacs's core functionality.")

(defvar savefile-dir (expand-file-name "savefile" emacs-dir)
  "This folder stores all the automatically generated save/history-files.")

(defvar modules-file (expand-file-name "modules.el" emacs-dir)
  "This files contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p savefile-dir)
  (make-directory savefile-dir))

(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(message "Loading Emacs's core...")

(require 'packages)
(require 'ui)
(require 'core)
(require 'editor)
(require 'global-keybindings)

(when (eq system-type 'darwin)
    (require 'os-x))

(message "Loading Emacs's modules...")

(when (file-exists-p modules-file)
  (load modules-file))

(message "Emacs is ready Master %s, Happy Hacking!" current-user)
