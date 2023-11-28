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
(setq doom-theme 'doom-one)
(custom-set-faces
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.25))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.5))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.75))))
 '(org-document-title ((t (:height 2.0)))))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; The most important part of the config


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-default-notes-file "~/org/inbox.org")

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

(use-package theme-changer
  :config
  ;; setq the location here.
  (setq calendar-location-name "Milan, Italy")
  (setq calendar-latitude 45.464664)
  (setq calendar-longitude 9.188540)
  (change-theme 'doom-one 'doom-one))

;; Different stuff
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
              (flycheck-add-next-checker 'python-flake8 'python-mypy))
            )
  )


(after! markdown-mode
  (custom-set-faces!
    '(markdown-header-delimiter-face :height 0.9)
    '(markdown-header-face-1 :height 1.8 :weight extra-bold :inherit markdown-header-face)
    '(markdown-header-face-2 :height 1.4 :weight extra-bold :inherit markdown-header-face)
    '(markdown-header-face-3 :height 1.2 :weight extra-bold :inherit markdown-header-face)
    '(markdown-header-face-4 :height 1.15 :weight bold :inherit markdown-header-face)
    '(markdown-header-face-5 :height 1.1 :weight bold :inherit markdown-header-face)
    '(markdown-header-face-6 :height 1.05 :weight semi-bold :inherit markdown-header-face))
  )

;; Improve org mode looks
(after! mixed-pitch
  (add-hook 'text-mode-hook #'mixed-pitch-mode)
  (set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 130)
  (set-face-attribute 'fixed-pitch nil :font "DejaVu Sans Mono")
  (set-face-attribute 'variable-pitch nil :font "DejaVu Sans"))
(add-hook 'mixed-pitch-mode-hook #'solaire-mode-reset)

(after! company-posframe
  (setq company-posframe-mode 1))

;; org-mode improvements
(defun org-icons ()
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
  (add-hook 'org-mode-hook (lambda () (company-mode -1)))
  (add-hook 'org-mode-hook 'org-icons)
  (setq-default line-spacing 6)
  (setq org-src-fontify-natively t
        org-startup-indented t
        org-pretty-entities t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(300)
        org-src-tab-acts-natively t
        org-src-preserve-indentation nil
        org-edit-src-content-indentation 0
        org-ellipsis " ▼ "
        )
  ;; Latex
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5))
  ;; Org-agenda
  (setq org-agenda-start-with-log-mode t
        org-log-done 'time)
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
  (setq org-fancy-priorities-list '("🔥" "🌊" "💤")
        org-agenda-block-separator 8411)
  (setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "WRITE(b)"           ; Blog writing assignments
           "PROJ(p)"           ; A project that contains other tasks
           "MEETING(m)"          ; Video assignments
           "LECTURE(l)"          ; Video assignments
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "NOTED(n)"           ; Task has been captured as a note
           "CANCELLED(c)" )))  ; Task has been cancelled
  ;; Org-capture
  (setq org-capture-templates
        '(("i" "Inbox" entry (file+headline "~/org/inbox.org" "Tasks")
           "* TODO %?\n %i\n %a")))
  ;; Org-babel
  (after! org-babel
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (emacs-lisp . t)
       (shell . t)
       (latex . t)
       ))))

(use-package! org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize-hook . org-modern-agenda)
         (global-org-modern-mode))
  :config
  (setq
   ;; Appearance
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-modern-radio-target    '("❰" t "❱")
   org-modern-internal-target '("↪ " t "")
   org-modern-todo t
   org-modern-tag t
   org-modern-timestamp t
   org-modern-statistics t
   org-modern-priority t
   org-modern-horizontal-rule "──────────"
   org-modern-hide-stars "·"
   org-modern-star ["⁖"]
   org-modern-keyword "‣"
   org-modern-list '((43 . "•")
                     (45 . "–")
                     (42 . "↪"))
   org-agenda-tags-column 'auto
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")

  (custom-set-faces!
    `((org-modern-tag)
      :background ,(doom-blend (doom-color 'blue) (doom-color 'bg) 0.1)
      :foreground ,(doom-color 'grey))
    `((org-modern-radio-target org-modern-internal-target)
      :inherit 'default :foreground ,(doom-color 'blue)))
  )


(after! org-appear
  (add-hook 'org-mode-hook #'org-appear-mode))

(map! :map org
      :leader
      :prefix ("n" . "notes")
      :desc "Render latex"      "L" #'org-latex-preview)


(setq org-agenda-custom-commands
      '(("d" "Today's Tasks"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-overriding-header "Today's Tasks")
                      ))))
        ("." "Todays Agenda"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-skip-deadline-prewarning-if-scheduled t)))))
        ("n" "Next Tasks"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))

        ("u" "Uni Tasks" tags-todo "+UNI")

        ;; Low-effort next actions
        ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)))))
