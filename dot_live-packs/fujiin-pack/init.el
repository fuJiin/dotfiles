;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")

;; Load Color scheme
(live-load-config-file "color-theme-conf.el")

;; Window Dimensions

(if (eq 'ns (window-system))
    (let ((w 143)
          (h 52))
      (add-to-list 'default-frame-alist `(width . ,w))
      (add-to-list 'default-frame-alist `(height . ,h))
      (set-frame-width (selected-frame) w)
      (set-frame-height (selected-frame) h))
  nil)

;; Fonts
(add-to-list 'default-frame-alist '(font . "Monaco-12"))
(set-face-attribute 'default nil :family "Monaco" :height 120)

;; Tabs
(let ((w 2))
  (setq tab-width w)
  (setq-default tab-width w))
