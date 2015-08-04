(use-package multi-term
  :ensure t
  ;; This fixes a bug with yas-snippets that breaks tab completion in
  ;; any term mode.
  ;; See https://github.com/capitaomorte/yasnippet/issues/289
  :init (add-hook 'term-mode-hook (lambda()
                                    (yas-minor-mode -1))))
