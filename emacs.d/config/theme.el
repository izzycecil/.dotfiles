;;
;; Startup message ;)
;;
(setq initial-scratch-message
      "
;;                      ░░░░░░░░░▄░░░░░░░░░░░░░░▄░░░░
;;                      ░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌░░░
;;     Such powerful    ░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐░░░
;;                      ░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐░░░
;;                      ░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐░░░  You and Emacs
;;                      ░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌░░░    So love
;;                      ░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌░░ Much forbidden
;;                      ░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐░░
;;  Very chords         ░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌░
;;                      ░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌░
;;                      ▀▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐░
;;                      ▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌
;;                      ▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐░
;;                      ░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌░
;;                      ░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐░░
;;                      ░░▀▄▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▄▒▒▒▒▌░░
;;                      ░░░░▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀░░░      Wow.
;;                      ░░░░░░▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀░░░░░
;;                      ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▀▀░░░░░░░░
;;  ██████╗  ██████╗  ██████╗ ███████╗███╗   ███╗ █████╗  ██████╗███████╗
;;  ██╔══██╗██╔═══██╗██╔════╝ ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
;;  ██║  ██║██║   ██║██║  ███╗█████╗  ██╔████╔██║███████║██║     ███████╗
;;  ██║  ██║██║   ██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
;;  ██████╔╝╚██████╔╝╚██████╔╝███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;;  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
  ")


;;
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
(use-package highlight-chars
 :ensure t
 :init
 (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
 (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace))

;; (use-package fill-column-indicator
;;   :ensure t
;;   :config (add-hook 'prog-mode-hook 'fci-mode))

;; Highlight line
(global-hl-line-mode)

;; Don't use messages that you don't read
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq ring-bell-function 'ignore)

;; Column numbers, please
(column-number-mode)

;; Relative linum mode
(use-package linum-relative
  :ensure t
  :config
  (global-linum-mode 1)
  (setq
   linum-relative-current-symbol ""
   linum-relative-format "%3s" ))

;; Fancy mode line
;; Todo: need to config this to do some nice things.
(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'respectful)
  (sml/setup))

;; No line-wrap
(set-default 'truncate-lines t)

;; Theme in X
(when (display-graphic-p)
  (use-package exec-path-from-shell
    :ensure t
    :config (exec-path-from-shell-initialize))
  ;; Transparency
  ;; (add-to-list 'default-frame-alist '(alpha 90 90))
  ;; No Scrollbar
  (scroll-bar-mode -1)
  ;; No Toolbar
  (tool-bar-mode -1)
  ;; No menu bar
  (menu-bar-mode -99)
  ;; Font
  (set-frame-font "Anonymous Pro 14"))

;;
;; I use smyx for dark, Solarized
;;
(add-to-list 'custom-theme-load-path "~/.emacs.d/smyx")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(setq-default frame-background-mode 'light)
(set-frame-parameter nil 'background-mode 'light)
(load-theme 'solarized t)
(load-theme 'smyx t)

(setq -toggle-theme 'smyx)
(defun toggle-theme ()
  "Toggles between Solarized-Light, and Smyx"
  (interactive)
  (if
      (equal -toggle-theme 'smyx)
      (progn (enable-theme 'solarized)
             (setq -toggle-theme 'solarized))
    (progn (enable-theme 'smyx)
           (setq -toggle-theme 'smyx))))
