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


;;
;; Spell check (we all know I need it!)
;;
(setq flyspell-issue-message-flag nil)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'flyspell-prog-mode)
(eval-after-load "flyspell" '(diminish 'flyspell-mode))

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
  (setq helm-autoresize-mode t
        helm-push-mark-mode  t
        helm-adaptative-mode t
        helm-quick-update    t
        helm-split-window-in-side-p t
        helm-buffers-fuzzy-matching t
        helm-move-to-line-cycle-in-source t
        helm-scroll-amount 8)
  (helm-mode 1))
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
