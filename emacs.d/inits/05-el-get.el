;; el-get
(setq el-get-dir "~/.emacs.d/el-get/")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;; define el-get repository
(setq el-get-sources
      '(
        (:name dmacro
               :description "dmacro mode"
               :type http
               :url "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
        ))

;; Packages to install from el-get
(defvar my/el-get-packages
  '(
    dmacro
    )
  "A list of packages to install from el-get at launch.")

(el-get 'sync my/el-get-packages)
