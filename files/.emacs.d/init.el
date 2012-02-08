;; Emacs Personalization
;;
;; Mon Nov  7 16:58:48 CST 2011 William Ingram <wingram2@illinois.edu>
;; Initial development
;;
;; Thu 19 Jan 2012 10:58:01 AM CST William Ingram wingram2@illinois.edu
;; Removed yasnippets -- doesn't play well in org-mode
;;


;; Packages
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")t)
(package-initialize)


(when (null package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-lisp 
                      starter-kit-bindings
                      starter-kit-ruby
                      markdown-mode
                      yasnippet
                      yaml-mode
                      ))
 
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                              '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

(fullscreen)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/work/org/work-log.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
