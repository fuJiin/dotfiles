;;; doom-pop-rocks-light-theme.el --- Pop Rocks light theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Elpizo Choi
;; Created: February 2026
;; Version: 1.0.0
;; Keywords: custom themes, faces
;; Homepage: https://github.com/elpizo/poprocks
;; Package-Requires: ((emacs "25.1") (doom-themes "2.1.6"))
;;
;;; Commentary:
;;
;; A light theme derived from Pop Rocks, with colors adjusted for light backgrounds.
;;
;;; Code:

(require 'doom-themes)

;;; Variables

(defgroup doom-pop-rocks-light-theme nil
  "Options for the `doom-pop-rocks-light' theme."
  :group 'doom-themes)

(defcustom doom-pop-rocks-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-pop-rocks-light-theme
  :type 'boolean)

(defcustom doom-pop-rocks-light-brighter-modeline nil
  "If non-nil, mode-line has a more vivid background color."
  :group 'doom-pop-rocks-light-theme
  :type 'boolean)

(defcustom doom-pop-rocks-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-pop-rocks-light-theme
  :type '(choice integer boolean))

;;; Theme definition

(def-doom-theme doom-pop-rocks-light
  "A light theme derived from Pop Rocks."

  ;; name        default   256           16
  ((bg         '("#fafafa" "#fafafa"     "white"        ))
   (fg         '("#383838" "#383838"     "black"        ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#f0f0f0" "#f0f0f0"     "white"        ))
   (fg-alt     '("#5a5a5a" "#5a5a5a"     "brightblack"  ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; temporary background and base8 is a strong foreground.
   (base0      '("#ffffff" "#ffffff"     "white"        ))
   (base1      '("#f5f5f5" "#f5f5f5"     "brightwhite"  ))
   (base2      '("#eeeeee" "#eeeeee"     "brightwhite"  ))
   (base3      '("#e0e0e0" "#e0e0e0"     "brightwhite"  ))
   (base4      '("#c0c0c0" "#c0c0c0"     "brightwhite"  ))
   (base5      '("#8a8c8d" "#8a8c8d"     "brightblack"  ))
   (base6      '("#636667" "#636667"     "brightblack"  ))
   (base7      '("#383838" "#383838"     "brightblack"  ))
   (base8      '("#171717" "#171717"     "black"        ))

   (grey       base5)
   (red        '("#d62558" "#d62558"     "red"          ))
   (orange     '("#c47a1a" "#c47a1a"     "brightred"    ))
   (green      '("#5a8c20" "#5a8c20"     "green"        ))
   (teal       '("#3d5a5f" "#3d5a5f"     "brightgreen"  ))
   (yellow     '("#9a8c30" "#9a8c30"     "yellow"       ))
   (blue       '("#2896a8" "#2896a8"     "brightblue"   ))
   (dark-blue  '("#1a6a78" "#1a6a78"     "blue"         ))
   (magenta    '("#7b5fc9" "#7b5fc9"     "brightmagenta"))
   (violet     '("#6a4ab8" "#6a4ab8"     "magenta"      ))
   (cyan       '("#2896a8" "#2896a8"     "brightcyan"   ))
   (dark-cyan  '("#3d5a5f" "#3d5a5f"     "cyan"         ))
   (pink       '("#d6608a" "#d6608a"     "red"          ))

   ;; These are the "universal syntax classes" that apply to most modes.
   (highlight      cyan)
   (vertical-bar   base3)
   (selection      '("#d0d5f0" "#d0d5f0" "brightwhite"  ))
   (builtin        cyan)
   (comments       (if doom-pop-rocks-light-brighter-comments teal grey))
   (doc-comments   (doom-darken comments 0.15))
   (constants      pink)
   (functions      cyan)
   (keywords       magenta)
   (methods        cyan)
   (operators      fg)
   (type           cyan)
   (strings        green)
   (variables      fg-alt)
   (numbers        pink)
   (region         selection)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (modeline-fg     fg)
   (modeline-fg-alt base5)
   (modeline-bg
    (if doom-pop-rocks-light-brighter-modeline
        (doom-lighten blue 0.45)
      base2))
   (modeline-bg-alt
    (if doom-pop-rocks-light-brighter-modeline
        (doom-lighten blue 0.475)
      `(,(doom-lighten (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-lighten (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-pop-rocks-light-padded-modeline
      (if (integerp doom-pop-rocks-light-padded-modeline) doom-pop-rocks-light-padded-modeline 4))))

  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-pop-rocks-light-brighter-comments (doom-darken bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground highlight)

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground cyan)
   ;;;; doom-modeline
   (doom-modeline-bar :background highlight)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#e0e0e0" :foreground "#383838")
   ;;;; ivy
   (ivy-current-match :background selection :distant-foreground base8 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground pink)
   ((markdown-code-face &override) :background (doom-darken base2 0.05))
   ;;;; org <built-in>
   (org-hide :foreground bg)
   ;;;; rjsx-mode
   (rjsx-tag :foreground pink)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt)))
   ;;;; web-mode
   (web-mode-html-tag-face :foreground pink)
   (web-mode-html-tag-bracket-face :foreground base7)
   (web-mode-html-attr-name-face :foreground orange))

  ;;;; Base theme variable overrides-
  ())

;;; doom-pop-rocks-light-theme.el ends here
