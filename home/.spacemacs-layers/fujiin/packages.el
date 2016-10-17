;;; packages.el --- fujiin Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq fujiin-packages
    '(
      ;; Clojure packages
      inf-clojure
      cljsbuild-mode

      ;; package fujiins go here
      (pop-rocks-theme :location local)
      ))

;; List of packages to exclude.
(setq fujiin-excluded-packages '())

;; For each package, define a function fujiin/init-<package-fujiin>
;;
;; (defun fujiin/init-<package-fujiin> ()
;;   "Initialize my package"
;;   )
(defun fujiin/init-inf-clojure ()
  (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode))

(defun fujiin/init-cljsbuild-mode ()
  )

(defun fujiin/init-pop-rocks-theme ()
  (use-package pop-rocks-theme
    :init
    (deftheme pop-rocks)))

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
