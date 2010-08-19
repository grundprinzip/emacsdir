;; Compile easy
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/git/bin:/usr/local/bin"))

;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
(setq load-path (append (list "~/emacs.d/elisp/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.gnuplot$" . gnuplot-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.plot$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
(global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------

;; Textmate mode
(add-to-list 'load-path "~/.emacs.d/elisp/textmate.el")
(require 'textmate)
(textmate-mode)

;; No backup files
(setq make-backup-files nil)

;; Line numbers in front of the line
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%2d ")

(setq load-path (cons "~/.emacs.d/elisp" load-path))

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/elisp/zen-and-art.el")
(color-theme-zen-and-art)

;; Set highlighting
;;(global-hl-line-mode 1)

;; Themes
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (color-theme-subdued)))


(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-really-aspell t)
(setq ispell-list-command "list")

;; `hunspell' extensions should be used
(setq ispell-really-hunspell nil)


;; (setq ispell-dictionary-alist
;;       ;; TODO Add es_ES
;;       '(
;;         ;; default dictionary (see `ispell-dictionary')
;;         (nil
;;          "[A-Za-z]"
;;          "[^A-Za-z]"
;;          "[']" nil
;;          ("-d" "en_US")  ; for hunspell
;;          nil utf-8)
;;         ))

(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Recent file mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Coding stytle
(add-hook 'c++-mode-hook
	  '(lambda () 
	     (c-set-style "bsd")
	     (setq indent-tabs-mode nil)
	     (setq c-basic-offset 4)))

(add-hook 'c-mode-hook
	  '(lambda () 
	     (c-set-style "bsd")
	     (setq indent-tabs-mode nil)
	     (setq c-basic-offset 4)))

(setq auto-mode-alist
            (append '(("\\.h$" . c++-mode)) auto-mode-alist))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))



;; Use php-mode for .php,.php3,.php4 and .phtml files

(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
(add-to-list 'auto-mode-alist
	          '("\\.php[34]\\'\\|\\.php\\'\\|\\.phtml\\'" . php-mode))


;;Add final new lines
(setq require-final-newline t)
;; y instead of yes
(fset 'yes-or-no-p 'y-or-n-p)
;; no empty lines
(setq next-line-add-newlines nil)


(setq display-time-day-and-date t) (display-time)




(require 'cl) ; If you don't have it already

(defun upward-find-file (filename &optional startdir)
  "Move up directories until we find a certain filename. If we
  manage to find it, return the containing directory. Else if we
  get to the toplevel directory and still can't find it, return
  nil. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
		    (if startdir startdir ".")))
	(found nil) ; found is set as a flag to leave loop if we find it
	(top nil))  ; top is set when we get
        ; to / so that we only check it once

    ; While we've neither been at the top last time nor have we found
    ; the file.
    (while (not (or found top))
      ; If we're at / set top flag.
      (if (string= (expand-file-name dirname) "/")
	    (setq top t))
      
      ; Check for the file
      (if (file-exists-p (expand-file-name filename dirname))
	    (setq found t)
	; If not, move up a directory
	(setq dirname (expand-file-name ".." dirname))))
    ; return statement
    (if found dirname nil)))

(setq compilation-scroll-output t)
(require 'compile)

(defun compile-next-makefile ()                                                           
  (interactive)                                                                           
  (let* ((default-directory (or (upward-find-file "Makefile") "."))                       
         (compile-command (concat "cd " default-directory " &&  make -j4")))                                      
    (compile compile-command))) 


;; (defun my-cedet-hook ()
;; (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;; (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;; (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;; (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
;; (add-hook 'c-mode-common-hook 'my-cedet-hook)
    

(global-set-key "\C-cc"       'compile-next-makefile)
(global-set-key "\C-cC"       'compile)
(global-set-key [f11]         'dabbrev-expand)
(define-key esc-map [f12]     'dabbrev-completion)
(global-set-key "\C-m"        'newline-and-indent)
