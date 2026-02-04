;;; doom-pop-rocks-theme.el --- Pop Rocks dark theme -*- lexical-binding: t; no-byte-compile: t; -*-
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
;; A dark theme inspired by the Pop Rocks TextMate/Sublime theme.
;;
;;; Code:

(require 'doom-themes)

;;; Variables

(defgroup doom-pop-rocks-theme nil
  "Options for the `doom-pop-rocks' theme."
  :group 'doom-themes)

(defcustom doom-pop-rocks-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-pop-rocks-theme
  :type 'boolean)

(defcustom doom-pop-rocks-brighter-modeline nil
  "If non-nil, mode-line has a more vivid background color."
  :group 'doom-pop-rocks-theme
  :type 'boolean)

(defcustom doom-pop-rocks-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-pop-rocks-theme
  :type '(choice integer boolean))

;;; Theme definition

(def-doom-theme doom-pop-rocks
  "A dark theme inspired by Pop Rocks."

  ;; name        default   256           16
  ((bg         '("#171717" "black"       "black"        ))
   (fg         '("#b0b0b0" "#b0b0b0"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#1e1e1e" "black"       "black"        ))
   (fg-alt     '("#728589" "#728589"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; temporary background and base8 is a strong foreground.
   (base0      '("#0d0d0d" "#0d0d0d"     "black"        ))
   (base1      '("#1b1d1e" "#1b1d1e"     "brightblack"  ))
   (base2      '("#252525" "#252525"     "brightblack"  ))
   (base3      '("#303030" "#303030"     "brightblack"  ))
   (base4      '("#505354" "#505354"     "brightblack"  ))
   (base5      '("#636667" "#636667"     "brightblack"  ))
   (base6      '("#8a8c8d" "#8a8c8d"     "brightblack"  ))
   (base7      '("#ccccc6" "#ccccc6"     "brightwhite"  ))
   (base8      '("#f8f8f2" "#f8f8f2"     "white"        ))

   (grey       base5)
   (red        '("#fa4786" "#fa4786"     "red"          ))
   (orange     '("#fda739" "#fda739"     "brightred"    ))
   (green      '("#c9ec79" "#c9ec79"     "green"        ))
   (teal       '("#5e7175" "#5e7175"     "brightgreen"  ))
   (yellow     '("#eadf8c" "#eadf8c"     "yellow"       ))
   (blue       '("#66d9ef" "#66d9ef"     "brightblue"   ))
   (dark-blue  '("#2896a8" "#2896a8"     "blue"         ))
   (magenta    '("#af8dfb" "#af8dfb"     "brightmagenta"))
   (violet     '("#9e6ffe" "#9e6ffe"     "magenta"      ))
   (cyan       '("#79e0f1" "#79e0f1"     "brightcyan"   ))
   (dark-cyan  '("#5e7175" "#5e7175"     "cyan"         ))
   (pink       '("#fd82ad" "#fd82ad"     "red"          ))

   ;; These are the "universal syntax classes" that apply to most modes.
   (highlight      cyan)
   (vertical-bar   base1)
   (selection      '("#464f94" "#464f94" "brightblack"  ))
   (builtin        cyan)
   (comments       (if doom-pop-rocks-brighter-comments dark-cyan grey))
   (doc-comments   (doom-lighten comments 0.15))
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
    (if doom-pop-rocks-brighter-modeline
        (doom-darken blue 0.45)
      base1))
   (modeline-bg-alt
    (if doom-pop-rocks-brighter-modeline
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-pop-rocks-padded-modeline
      (if (integerp doom-pop-rocks-padded-modeline) doom-pop-rocks-padded-modeline 4))))

  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-pop-rocks-brighter-comments (doom-lighten bg 0.05)))
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
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background selection :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground pink)
   ((markdown-code-face &override) :background (doom-lighten base2 0.05))
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

;;; doom-pop-rocks-theme.el ends here
