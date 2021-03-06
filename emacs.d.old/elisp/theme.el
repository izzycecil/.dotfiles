;;
;; File: themeconfig.el
;; Author: Izzy Cecil
;; Date: Sun Nov  1 16:03:20 MST 2015
;;
;; This file defines everything that I like to configure how emacs
;; looks and feels.

(use-package spaceline-config
  :ensure spaceline
  :config
  (spaceline-spacemacs-theme)
  (setq powerline-default-separator         'wave
        spaceline-workspace-numbers-unicode t
        spaceline-window-numbers-unicode    t
        spaceline-highlight-face-func       'spaceline-highlight-face-evil-state))


;; Rainbow Delims
;;
(use-package rainbow-delimiters
  :ensure t
  :diminish rainbow-delimiters-mode
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;
;; Highlights matching parens.
;;
(show-paren-mode 1)
(setq show-paren-style `parenthesis)

;;
;; y-or-n over yes-or-no
;;
(fset 'yes-or-no-p 'y-or-n-p)

;; Sets a gutter between linnums and text
(unless window-system
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length (number-to-string
                                            (count-lines (point-min) (point-max))))))
                            (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'mode-line)))

(unless window-system
  (setq linum-format 'linum-format-func))

;; Highlight things I hate
;; (use-package highlight-chars
;;   :ensure t
;;   :init
;;   (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
;;   (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace))

(use-package fill-column-indicator
  :ensure t
  :config
  (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
  (global-fci-mode 1))

;; Highlight line
(global-hl-line-mode)

;; Don't use messages that you don't read
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq ring-bell-function 'ignore)

;; Relative linum mode
(use-package linum-relative
  :ensure t
  :init
  (setq linum-relative-current-symbol ""
        linum-relative-format         "%3s"
        linum-relative-plusp-offset   1)
  :config
  (linum-relative-on)
  (global-linum-mode))

;; No line-wrap
(set-default 'truncate-lines t)

(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-light t)
  (setq solarized-use-terminal-theme t ))
;; (load-theme 'whiteboard t)

;; Theme in X
(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))
;; No Scrollbar
(scroll-bar-mode -1)
;; No Toolbar
(tool-bar-mode -1)
;; No menu bar
(menu-bar-mode -99)
;; Font
(add-to-list 'default-frame-alist '(font . "Anonymous Pro 11"))
