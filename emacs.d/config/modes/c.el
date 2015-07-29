(add-hook 'c-mode-common-hook
          (lambda () (use-package clang-format
                       :ensure t
                       :bind ("C-F" . clang-format-buffer))))
