(use-package clang-format
  :ensure t
  :commands clang-format-buffer
  :init
  (progn (require 'cc-mode)
         (bind-key "C-F" 'clang-format-buffer c-mode-base-map)))
