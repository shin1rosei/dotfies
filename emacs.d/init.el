;;; init.el --- init file

;;; Commentary:

;;; Code:

;;; add load path
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/el-get/el-get/")
        )
       load-path))

(eval-when-compile (require 'cl))

;; package.el setting
(require 'package)
(add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/")  t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;; install if not installed
(defvar my-package-list
  '(auto-async-byte-compile
    auto-complete
    cperl-mode
;;    direx
    exec-path-from-shell
    color-theme-solarized
;;    expand-region
    flycheck
    go-autocomplete
    go-eldoc
    go-mode
    golint
    git-gutter
    helm
    helm-ag
;;    helm-descbinds
;;    helm-go-package
    helm-perldoc
    helm-projectile
    init-loader
;;    js2-mode
;;    magit
;;    markdown-mode
;;    open-junk-file
    perl-completion
    powerline
    plenv
    recentf-ext
;;    ruby-mode
;;    shell-pop
    smooth-scroll
;;    undo-tree
    yaml-mode
    yascroll
;;    yasnippet
	))

(let ((not-installed
       (loop for package in my-package-list
             when (not (package-installed-p package))
             collect package)))
  (when not-installed
    (package-refresh-contents)
    (dolist (package not-installed)
      (package-install package))))

;; init loader
(require 'init-loader)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cperl-auto-newline nil)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-parens-as-block t)
 '(cperl-indent-subs-specially nil)
 '(dired-use-ls-dired nil)
 '(exec-path-from-shell-variables (quote ("PATH" "MANPATH" "GOPATH")))
 '(find-file-visit-truename t)
 '(helm-boring-file-regexp-list (quote ("~$" "\\.elc$")))
 '(helm-buffer-max-length 35)
 '(helm-command-prefix-key "C-z")
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-ff-skip-boring-files t)
 '(helm-split-window-default-side (quote right))
 '(helm-truncate-lines t t)
 '(indent-tabs-mode nil)
 '(init-loader-show-log-after-init nil)
 '(initial-frame-alist (quote ((alpha . 100))))
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(ns-alternate-modifier (quote alt))
 '(ns-command-modifier (quote meta))
 '(ns-use-native-fullscreen nil)
 '(package-selected-packages
   (quote
    (helm-projectile helm-perldoc helm-ag helm yascroll yaml-mode smooth-scroll shell-pop recentf-ext projectile powerline plenv perl-completion init-loader golint go-eldoc go-autocomplete git-gutter flycheck exec-path-from-shell deferred color-theme-solarized auto-async-byte-compile async)))
 '(read-file-name-completion-ignore-case t)
 '(ruby-deep-indent-paren nil)
 '(scroll-bar-mode nil)
 '(smooth-scroll/vscroll-step-size 10)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(whitespace-style (quote (face tabs trailing empty tab-mark))))
(init-loader-load)

;; after init
(add-hook 'after-init-hook
          (lambda ()
            ;; show init time
            (message "init time: %.3f sec"
                     (float-time (time-subtract after-init-time before-init-time)))))

;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(yascroll:thumb-fringe ((t (:background "slate gray" :foreground "slate gray")))))
