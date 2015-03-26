(require 'gitattributes-mode)

(require 'gitconfig-mode)

(require 'gitignore-mode)

(autoload 'gitignore-mode "gitignore-mode"
  "Major mode for editing .gitignore files" t)

(autoload 'gitattributes-mode "gitattributes-mode"
  "Major mode for editing git attributes files" t)

(autoload 'gitconfig-mode "gitconfig-mode "
  "Major mode for editing git config files" t)

(provide 'init-git-modes)
