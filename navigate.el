;;; navigate.el --- Seamlessly navigate between Emacs and kitty

;; Author: Guilherme Zagatti
;; Created:  Feb 11 2021
;; Version:  0.1.5
;; Keywords: kitty, evil, vi, vim
;; 
;; Based on evil-tmux-navigator 
;; from Keith Smiley <keithbsmiley@gmail.com>

;;; Commentary:

;; This package is inspired by
;; vim-kitty-navigator and evil-tmux-navigator.
;; It allows you to navigate splits in evil mode
;; along with kitty splits with the same commands
;; Include with:
;;
;;    (require 'navigate)
;;

;;; Code:

(require 'evil)

(defgroup navigate nil
  "seamlessly navigate between Emacs and kitty"
  :prefix "navigate-"
  :group 'evil)

; Without unsetting C-h this is useless
(global-unset-key (kbd "C-h"))

; This requires windmove commands
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(defun kitty-navigate (direction)
  (let
    ((cmd (concat "windmove-" direction)))
      (condition-case nil
          (funcall (read cmd))
        (error
          (kitty-command direction)))))

(defun kitty-command (direction)
  (shell-command-to-string
    (concat "kitty @ kitten neighboring_window.py "
      (kitty-direction direction))))

(setq kitty-emacs-table (make-hash-table :test 'equal))
(setf (gethash "left" kitty-emacs-table) "left")
(setf (gethash "down" kitty-emacs-table) "bottom")
(setf (gethash "up" kitty-emacs-table) "top")
(setf (gethash "right" kitty-emacs-table) "right")

(defun kitty-direction (direction)
  (gethash direction kitty-emacs-table))

(define-key evil-normal-state-map
            (kbd "C-h")
            (lambda ()
              (interactive)
              (kitty-navigate "left")))
(define-key evil-normal-state-map
            (kbd "C-j")
            (lambda ()
              (interactive)
              (kitty-navigate "down")))
(define-key evil-normal-state-map
            (kbd "C-k")
            (lambda ()
              (interactive)
              (kitty-navigate "up")))
(define-key evil-normal-state-map
            (kbd "C-l")
            (lambda ()
              (interactive)
              (kitty-navigate "right")))

(provide 'navigate)

;;; navigate.el ends here
