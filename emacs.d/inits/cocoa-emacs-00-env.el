;;; environment variables

(let*
    ((path (list "~/homebrew/bin"
                 "~/.plenv/shims")))
  (dolist (p path)
    (add-to-list 'exec-path (expand-file-name p))
    (setenv "PATH" (concat (expand-file-name p) ":" (getenv "PATH")))))

(require 'exec-path-from-shell)
(custom-set-variables
 '(exec-path-from-shell-variables '("PATH" "MANPATH" "GOPATH")))
(setenv "SHELL" (executable-find "zsh"))
(exec-path-from-shell-initialize)
