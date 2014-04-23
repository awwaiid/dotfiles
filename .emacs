(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

; Now you can use C-\ to toggle between evil and evil-mode :)
(global-set-key (kbd "C-\\") 'evil-mode)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
