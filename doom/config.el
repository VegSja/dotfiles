;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vegard Sjåvik"
      user-mail-address "vgsjaavik@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 16 :weight 'normal))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-material-dark)
(custom-theme-set-faces!
'doom-material-dark
'(org-level-4 :inherit outline-4 :height 1.1)
'(org-level-3 :inherit outline-3 :height 1.25)
'(org-level-2 :inherit outline-2 :height 1.5)
'(org-level-1 :inherit outline-1 :height 1.75)
'(org-document-title :height 2.0 :underline nil))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

; General stuff
(setq +format-with-lsp nil)
(after! flycheck-posframe
        (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
        (flycheck-posframe-configure-pretty-defaults))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

; copilot-stuff
; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))


; Python stuff
(after! dap-mode
  (setq dap-python-debugger 'debugpy))


(after! python
        (add-hook 'python-mode-hook #'flycheck-mode)
        (add-hook 'python-mode-hook
            (lambda ()
              (setq-local flycheck-checker 'python-mypy)
              (flycheck-add-next-checker 'python-flake8 'python-mypy))))

;; org-mode improvements
(after! org
  (setq org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0)
        (setq org-agenda-files (list "~/org/")))

(after! org-roam
  (setq org-roam-directory (file-truename "~/org/roam/"))
  (setq org-complete-everywhere t)
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("b" "book note" plain
           "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title} \n#+filetags: Book\n")
           :unnarrowed t)
          ("a" "article note" plain
           "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nURL: $^{URL}\n\n* Summary\n\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title} \n#+filetags: Article\n")
           :unnarrowed t)
          ("c" "class note" plain
           "\n* General information\nClassname: ${title}\nAbbreviated: ${abbreviation}\nLecture schedule:\nProfessor: %^{Professor}\nYear: %^{Year}\nSemester: %^{semester}\n* Exercise information\n* Exam information\n\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title} \n#+filetags: Class\n")
           :unnarrowed t)))
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-setup))

;; Improve org mode looks
(after! mixed-pitch
    (add-hook 'text-mode-hook #'mixed-pitch-mode)
    (set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 130)
    (set-face-attribute 'fixed-pitch nil :font "DejaVu Sans Mono")
    (set-face-attribute 'variable-pitch nil :font "DejaVu Sans"))
(add-hook 'mixed-pitch-mode-hook #'solaire-mode-reset)

(after! company-posframe
  (setq company-posframe-mode 1))

(setq org-startup-indented t
        org-pretty-entities t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(300))

(defun org-icons ()
   "Beautify org mode keywords."
        (setq prettify-symbols-alist
        '(("#+begin_src" . ?)
        ("#+BEGIN_SRC" . ?)
        ("#+end_src" . ?)
        ("#+END_SRC" . ?)
        ("#+begin_example" . ?)
        ("#+BEGIN_EXAMPLE" . ?)
        ("#+end_example" . ?)
        ("#+END_EXAMPLE" . ?)
        ("#+header:" . ?)
        ("#+HEADER:" . ?)
        ("#+name:" . ?﮸)
        ("#+NAME:" . ?﮸)
        ("#+results:" . ?)
        ("#+RESULTS:" . ?)
        ("#+call:" . ?)
        ("#+CALL:" . ?)
        (":PROPERTIES:" . ?)
        (":properties:" . ?)
        (":LOGBOOK:" . ?)
        (":logbook:" . ?)))
        (prettify-symbols-mode 1))
(after! org
  (after! org-appear
    (add-hook 'org-mode-hook #'org-appear-mode))
  (after! org-superstar)
    (add-hook 'org-mode-hook
              (lambda () (org-superstar-mode 1)))
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5))
  (add-hook 'org-mode-hook 'org-icons)
  ;; Increase line spacing
  (setq-default line-spacing 6)
  )

;; Keys
(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug
      :desc "dap disconnect"    "q" #'dap-disconnect

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

(map! :map org
      :leader
      :prefix ("n" . "notes")

      :desc "Render latex"      "L" #'org-latex-preview)
