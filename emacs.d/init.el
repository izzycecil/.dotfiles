;;
;; File:   init.el
;; Author: Izzy Cecil
;; Date:   Sat Mar 28 13:30:00 MDT 2015
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;
;; Initialize packages and setup use-package
;;
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;
;; Use-package init
;;
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;;
;; Load recursive loader, utilities, and configurations.
;;
(load "~/.emacs.d/lisp/load-directory.el")
(load-directory "~/.emacs.d/lisp")
(load-directory "~/.emacs.d/config")
