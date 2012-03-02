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

(fullscreen)

;; zenburn ( until they fix it in marmalade )
;; (load
;; (expand-file-name "~/.emacs.d/elisp/zenburn-theme-1.2.el"))

(load-theme 'wombat)

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
 '(:file-suffix        	    ".txt"
     :key-binding                   ?T

     :header-prefix            	    ""
     :header-suffix            	    ""

     :title-format             	    ""

     :date-export        	        t
     :date-format                   ""

     :toc-export                    nil

     :body-header-section-numbers   nil
     :body-section-prefix           "\n"

     :body-section-header-prefix    ("---+ " "---++ "
				     "---+++ " "---++++ " "---+++++ ")
     :body-section-header-suffix    ("\n" "\n" "\n" "\n" "\n")

     :body-line-export-preformated  t          ;; yes/no/maybe???
     :body-line-format              "%s\n"
     :body-line-wrap                75

     :body-line-fixed-prefix       "<verbatim>\n"
     :body-line-fixed-format       "%s\n"
     :body-line-fixed-suffix       "</verbatim>\n"

     :body-list-format              "%s\n"
     :body-number-list-format       "  # %s\n"

     :body-bullet-list-prefix       ("   * " "      * " "         * "
                                     "            * " "               * ")
     )
 )

;; Export for confluence
(org-set-generic-type
 "confluence"
 '(:file-suffix        	    ".txt"
     :key-binding                   ?C

     :header-prefix            	    ""
     :header-suffix            	    ""

     :title-format             	    "{panel:bgColor=#f0f0f0}\n{toc:outline=true|style=none|indent=10px}\n{panel}\n\n"

     :date-export        	        t
     :date-format                   ""

     :toc-export                    nil

     :body-header-section-numbers   nil
     :body-section-prefix           ""
     :body-section-suffix           "\n"

     :body-section-header-prefix    ("h1. " "h2. " "h3. " "h4. " "h5. ")
     :body-section-header-suffix    ("\n" "\n" "\n" "\n" "\n")

     :body-line-export-preformated  t          ;; yes/no/maybe???
     :body-line-format              "%s\n"
     :body-line-wrap                75

     :body-line-fixed-prefix        "{{"
     :body-line-fixed-format        "%s"
     :body-line-fixed-suffix        "}}"

     :body-list-format              "%s\n"
     :body-number-list-format       "# %s\n"

     :body-bullet-list-prefix       ("* " "** " "*** " "**** " "***** ")

     :body-list-checkbox-todo       "{{\[ \]}} "
     :body-list-checkbox-todo-end   ""
     :body-list-checkbox-done       "{{\[X\]}} "
     :body-list-checkbox-done-end   ""
     :body-list-checkbox-half       "{{\[-\]}} "
     :body-list-checkbox-half-end   ""

     )
 )

'(org-agenda-files (quote ("~/Dropbox/work/org/work-log.org")))

(find-file (expand-file-name "~/Dropbox/work/org/ideals-todo.org"))

(server-start)
