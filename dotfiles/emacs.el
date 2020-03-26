;;; emacs.el --- provides EMACS config.
;;; Commentary:

;;; Code:
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))
(add-hook 'focus-out-hook 'garbage-collect)

(setq user-full-name "Stanislaw Karkavin"
      user-mail-address "me@xdefrag.dev")

(blink-cursor-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(set-window-scroll-bars (minibuffer-window) nil nil)
(global-prettify-symbols-mode t)

(setq-default
 mode-line-format nil
 electric-indent-inhibit t
 ring-bell-function 'ignore
 scroll-conservatively 100)

(setq-default
 backup-directory-alist `(("." . "~/.emacs.backup"))
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 10
 kept-old-versions 2
 version-control t
 auto-save-visited-mode t)

(setenv "SHELL" "/bin/zsh")

(use-package evil
	     :ensure t
	     :config (evil-mode))

(use-package go-mode
             :ensure t
	     :commands (go-mode))

(use-package lsp-mode
	     :ensure t
	     :commands (lsp lsp-deferred)
	     :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
	     :ensure t
	     :config
	     ;; Optionally enable completion-as-you-type behavior.
	     (setq company-idle-delay 0)
	     (setq company-minimum-prefix-length 1))

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
	     :ensure t
	     :commands company-lsp)

;; Optional - provides snippet support.
(use-package yasnippet
	     :ensure t
	     :commands yas-minor-mode
	     :hook (go-mode . yas-minor-mode))

(provide 'emacs.el)
;;; emacs.el ends here
