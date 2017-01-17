;;
;; File: behaviorconfig.el
;; Author: Izzy Cecil
;; Date: Sun Nov  1 16:14:27 MST 2015
;;
;; Configures how emacs should function globally. Things such as spell
;; check, helm, ect... go here.
;;

(defun behaviorconfig-init ()
  ;;
  ;; Don't tell me this is a server, I don't care
  ;;
  (diminish 'server-buffer-clients)

  ;;
  ;; Always use an existing window
  ;;
  (setq ns-pop-up-frames nil)

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
  (add-hook 'text-mode-hook 'flyspell-mode)
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

  (use-package company
    :ensure t
    :diminish company-mode
    :config
    (global-company-mode)
    (use-package company-quickhelp
      :ensure t
      :config
      (company-quickhelp-mode 1))
    ;; Taken from https://github.com/company-mode/company-mode/issues/180#issuecomment-55047120
    (defvar-local company-fci-mode-on-p nil)

    (defun company-turn-off-fci (&rest ignore)
      (when (boundp 'fci-mode)
        (setq company-fci-mode-on-p fci-mode)
        (when fci-mode (fci-mode -1))))

    (defun company-maybe-turn-on-fci (&rest ignore)
      (when company-fci-mode-on-p (fci-mode 1)))

    (add-hook 'company-completion-started-hook 'company-turn-off-fci)
    (add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
    (add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci))

  (use-package flycheck
    :ensure t
    :diminish flycheck-mode
    :init (global-flycheck-mode))

  ;;
  ;; Hastbin. If I haste a selection, it posts it to hastebin, and gives me a link.
  ;;
  (use-package haste
    :ensure t)

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

  (use-package which-key
    :ensure t
    :diminish which-key-mode
    :config
    (which-key-mode 1)
    (which-key-setup-side-window-bottom))

  (use-package ace-jump-mode
    :ensure t
    :config
    (evil-leader/set-key "<SPC>" 'evil-ace-jump-word-mode)
    (evil-leader/set-key "S-<SPC>" 'evil-ace-jump-char-mode))

  (evil-leader/set-key
    "bb" 'compile
    "bn" 'next-error
    "bp" (lambda () (interactive) (next-error -1))))

(provide 'behaviorconfig)
