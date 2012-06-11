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
                      starter-kit-eshell
                      css-mode
                      ruby-mode
                      clojure-mode
                      markdown-mode
                      sass-mode
                      haml-mode                      
                      yasnippet
                      yaml-mode
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; fullscreen
(defun fullscreen (&optional f)
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

;; (fullscreen)

;; zenburn ( until they fix it in marmalade )
;; (load
;; (expand-file-name "~/.emacs.d/elisp/zenburn-theme-1.2.el"))

(load-theme 'wombat)

(global-linum-mode t)

;; org stuff
(setq load-path (cons "~/.emacs.d/elisp/org-mode/lisp" load-path))
(setq load-path (cons "~/.emacs.d/elisp/org-mode/contrib/lisp" load-path))
(require 'org-install)

(setq load-path (cons "~/.emacs.d/elisp/org-confluence" load-path))
(require 'org-confluence)

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map "\C-ca"
               'org-agenda)))

(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "|" "DONE(d)")))

(setq org-directory "~/Dropbox/work/org")
(setq org-default-notes-file (concat org-directory "/todo.org"))
(define-key global-map "\C-cr" 'org-remember)

(load
 (expand-file-name "~/.emacs.d/elisp/org-export-generic.el"))

;; Export for twiki
(org-set-generic-type
 "twiki"
 '(
:file-suffix                    ".twiki"
:key-binding                    ?K
:header-prefix                  ""
:header-suffix                  "---\n\n"
:title-format                   "---+ %s\n"

:date-exportnil                 
:toc-exportnil

:timestamps-export              t
:priorities-export              t
:todo-keywords-export           t
:author-export                  t
:tags-export                    t

:body-header-section-numbers    nil
:body-section-prefix            "\n"

:body-section-header-prefix     ("---++ " "---+++ " "---++++ " "---+++++" "---++++++ ")
:body-section-header-suffix     "\n\n"

:body-line-export-preformated   t
:body-line-fixed-prefix         "<VERBATIM>\n"
:body-line-fixed-suffix         "\n</VERBATIM>\n"
:body-line-fixed-format         "%s\n"

;; other body lines
:body-line-format               "%s\n"
:body-line-wrap                 80

;; TN: apparently hierarchies of lists are not taken into account
;; (all items displayed on the same level) 
:body-list-format               " * %s\n"
:body-number-list-format        " 1.%s\n"
:body-number-list-leave-number  nil

:body-bullet-list-prefix        ?\s
:body-bullet-list-format        "* %s\n"

:body-list-checkbox-todo        "%P% "
:body-list-checkbox-todo-end    ""
:body-list-checkbox-done        "%Y%"
:body-list-checkbox-done-end    ""
:body-list-checkbox-half        ":wip:"
:body-list-checkbox-half-end	""   
   )
 )

'(org-agenda-files (quote ("~/Dropbox/work/org/work-log.org")))

(find-file (expand-file-name "~/Dropbox/work/org/ideals-todo.org"))

(server-start)

;; setup align for ruby-mode
(require 'align)

(defconst align-ruby-modes '(ruby-mode)
  "align-perl-modes is a variable defined in `align.el'.")

(defconst ruby-align-rules-list
  '((ruby-comma-delimiter
     (regexp . ",\\(\\s-*\\)[^/ \t\n]")
     (modes  . align-ruby-modes)
     (repeat . t))
    (ruby-string-after-func
     (regexp . "^\\s-*[a-zA-Z0-9.:?_]+\\(\\s-+\\)['\"]\\w+['\"]")
     (modes  . align-ruby-modes)
     (repeat . t))
    (ruby-symbol-after-func
     (regexp . "^\\s-*[a-zA-Z0-9.:?_]+\\(\\s-+\\):\\w+")
     (modes  . align-ruby-modes)))
  "Alignment rules specific to the ruby mode.
See the variable `align-rules-list' for more details.")

(add-to-list 'align-perl-modes 'ruby-mode)
(add-to-list 'align-dq-string-modes 'ruby-mode)
(add-to-list 'align-sq-string-modes 'ruby-mode)
(add-to-list 'align-open-comment-modes 'ruby-mode)
(dolist (it ruby-align-rules-list)
  (add-to-list 'align-rules-list it))


;; Zulu date
(defun insert-date-time ()
  "Insert current date-time string in full
ISO 8601 format.
Example: 2010-11-29T23:23:35-08:00
See: URL `http://en.wikipedia.org/wiki/ISO_8601'
"
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end) )
    )
  (insert
   (concat
    (format-time-string "%Y-%m-%dT%T")
    ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
     (format-time-string "%z")))))


;; 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/work/org/ideals-todo.org"))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
