;; Show line numbers globally:
(global-linum-mode t)

;; Set font size:
(set-face-attribute 'default nil :height 100) ;; Font size x10

;; Set tab width to 4 - for CC Mode languages (C, C++, Java et al.):
(setq-default tab-width 4) ; or any other preferred value
(setq cua-auto-tabify-rectangles nil)
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))
(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
        (indent-tabs-mode
         (save-excursion
           (beginning-of-line)
           (while (looking-at "\t*\\( +\\)\t+")
             (replace-match "" nil nil nil 1)))
         (setq tab-width tab-width)
         (let ((tab-width fill-column)
               (,offset fill-column)
               (wstart (window-start)))
           (unwind-protect
               (progn ad-do-it)
             (set-window-start (selected-window) wstart))))
        (t
         ad-do-it)))))
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

;; Set emacs to delete the selected text when you press DEL, Ctrl-d, or Backspace:
(delete-selection-mode t)

;; Set default color theme:
(require 'color-theme)
(color-theme-initialize)
(color-theme-gray30)

;; Disable menubar and toolbar:
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Highlight matching brakets:
(show-paren-mode 1)

;; Goto line number shortcut:
(global-set-key "\C-l" 'goto-line)

;; Auto-completion:
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1//ac-dict")
(ac-config-default)

;; Never show startup dialog:
(setq inhibit-startup-message t)

;; Show selection from mark:
(transient-mark-mode t)

;; Use y/n for questions, instead of yes/no:
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable syntax highlighting globally:
(global-font-lock-mode t)

;; Better buffer switching:
(iswitchb-mode 1)

;; Scroll (mouse+keyboard) one line at a time (less "jumpy" than defaults)
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; One line at a time
(setq mouse-wheel-progressive-speed nil)            ;; Do not accelerate scrolling
;;(setq mouse-wheel-follow-mouse 't)                  ;; Scroll window under mouse
;;(setq scroll-step 1)                                ;; Keyboard scroll one line at a time
(defun scroll-two-down ()
  (interactive)
  (scroll-down 2)
  (previous-line)
  (previous-line)
)
(global-set-key [(control ?.)] 'scroll-two-down)

(defun scroll-two-up ()
  (interactive)
  (scroll-up 2)
  (next-line)
  (next-line)
)
(global-set-key [(control ?,)] 'scroll-two-up)
