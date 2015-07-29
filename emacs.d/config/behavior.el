;;
;; General behavior of emacs. Behaviors which should act globally.
;; This tends to include things like movement, completion, saving
;; behavior, ect...
;;

;;
;; Acejump mode lets me move around the screen quickly
;;
(use-package ace-jump-mode
  :ensure t
  :bind ("C-g" . ace-jump-mode))

(defun smart-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.
If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'smart-move-beginning-of-line)

;;
;; YAS
;;
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config (yas-global-mode 1))

;;
;; Electric modes
;;
(electric-pair-mode 1)
(add-to-list 'electric-pair-pairs '(?\{ . ?\}))
(electric-indent-mode 1)

;;
;; Spell check (we all know I need it!)
;;
(setq flyspell-issue-message-flag nil)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'flyspell-prog-mode)
(eval-after-load "flyspell" '(diminish 'flyspell-mode))
;; (use-package helm-flyspell
;;   :ensure t
;;   :bind ("M-$" . helm-flyspell-correct))

;;
;; Autofill for text mode
;;
(add-hook 'text-mode-hook 'auto-fill-mode)

;;
;; Projectile. This tells emacs to treat git repos as projects.
;; By doing this, I can do some neat helm things.
;;
(use-package projectile
  :ensure t)

;;
;; Company-mode
;;
(use-package company
  :ensure t
  :config (global-company-mode t))

;;
;; Helm. A very nice/fancy selection engine.
;;
;; helm-autoresize-mode                : Auto resize the complete window
;; helm-push-mark-mode                 : Helm movements will push the mark
;; helm-quick-update                   : do not display invisible candidates
;; helm-split-window-in-side-p         : open helm buffer inside current window, not occupy whole other window
;; helm-buffers-fuzzy-matching t       : fuzzy matching buffer names when non--nil
;; helm-move-to-line-cycle-in-source t : move to end or beginning of source when reaching top or bottom of source.
;; helm-scroll-amount 8                : scroll 8 lines other window using M-<next>/M-<prior>
;;
;; TODO: I need to continue to look into this, and see if I'm using everything I
;; could be.
;;
(use-package helm
  :ensure t
  :demand
  :diminish helm-mode
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring))
  :config
  ;; rebind tab to run persistent action
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  ;; make TAB works in terminal
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  ;;list actions using C-z
  (define-key helm-map (kbd "C-z")  'helm-select-action)
  (setq helm-quick-update                 t
        helm-split-window-in-side-p       t
        helm-buffers-fuzzy-matching       t
        helm-move-to-line-cycle-in-source t
        helm-scroll-amount                8)
  (helm-mode            t)
  (helm-autoresize-mode t)
  (helm-adaptive-mode   t)
  ;; (helm-push-mark-mode  t)
  )

(use-package helm-company
  :ensure t)


;;
;; Hastbin. If I haste a selection, it posts it to hastebin, and gives me a link.
;;
(use-package haste
  :ensure t)

;;
;; Inc / Dec numbers with C-c +/-
;;
(use-package evil-numbers
  :ensure t
  :bind (("C-c +" . evil-numbers/inc-at-pt)
         ("C-c -" . evil-numbers/dec-at-pt)))

;;
;; File Settings
;;
;; Makes <filename>~ be a copy ONLY WHEN the original file is hard
;; linked. See http://kb.iu.edu/data/acxl.html for more.
(setq backup-by-copying-when-linked t)

;; Make intermediate dirs when saving
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p
                            (format "Directory %s does not exist. Create it?"
                                    dir)))
                  (make-directory dir t))))))

;; Remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Always reload files when changed on disk
(global-auto-revert-mode t)
