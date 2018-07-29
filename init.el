(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
;;  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; go specific stuff
(setq gofmt-command "~/go/bin/goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; MAIL SETTINGS
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-maildir "~/Pressmail")
(setq mu4e-sent-folder "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder "/Trash")
;; maildir shortcuts
(setq mu4e-maildir-shortcuts
      '(("/INBOX" . ?i)
	("/Sent"  . ?s)))
(setq
 user-mail-address "ianmcgaunn@pressmail.ch"
 user-full-name "Ian McGaunn")
(setq message-kill-buffer-on-exit t)
(setq mu4e-view-show-images t)
(setq mu4e-use-fancy-chars t)
(setq mu4e-get-mail-command "offlineimap")
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "msmtp"
      mail-specify-envelope-from t
      message-sendmail-f-is-evil nil
      mail-envelope-from 'header
      message-sendmail-envelope-from 'header)

;; misc
(ivy-mode 1)
(counsel-mode 1)
(linum-mode 1)
(global-company-mode) ;; completion
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; appearance
(set-background-color "honeydew")
(set-frame-font "-*-Menlo-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1")
(setq scroll-bar-mode nil)
(setq tool-bar-mode nil)

;; project settings
(projectile-mode 1)
(setq projectile-project-search-path '("~/go/src/" "~/Development/"))

(global-set-key (kbd "C-c C-;") 'er/expand-region)
(global-set-key (kbd "C-c t") 'shell)
(global-set-key (kbd "C-S-s") 'isearch-forward-regexp)
(setq visible-bell t)

;; go specific keybindings / settings.
(defun go-mode-config ()
  "use with go-mode-hook"
  (local-set-key (kbd "C-c C-c") 'shell))
(add-hook 'go-mode-hook 'go-mode-config)

;; elisp specific keybindings /settings
(defun elisp-mode-config ()
  (local-set-key (kbd "C-c C-r" 'eval-region)))
(add-hook 'elisp-mode-hook 'elisp-mode-config)

(add-to-list 'default-frame-alist
	     '(font . "-*-Menlo-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1"))
(add-to-list 'default-frame-alist
	     '(background-color . "honeydew")) ;; this background-color setting doesn't work, and I'm not sure why :(
