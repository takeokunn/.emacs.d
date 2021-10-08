EMACS ?= emacs

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

HTMLIZE_FILE=$(TOP_DIR)/htmlize.el
HTMLIZE_URL=https://raw.githubusercontent.com/hniksic/emacs-htmlize/master/htmlize.el

.PHONY: all
all: compile org-to-html org-generate

.PHONY: clean
clean:
	rm -f  ~/.emacs.d/.junk/*

.PHONY: link
link:
	ln -nfs $(TOP_DIR) ~/

.PHONY: compile
compile:
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./index.org\" \"./init.el\" \"emacs-lisp\"))"
	$(EMACS) -Q --batch -f batch-byte-compile init.el

.PHONY: org-to-html
org-to-html: $(HTMLIZE_FILE)
	$(EMACS) index.org -Q --batch --eval "(progn (load \""$(HTMLIZE_FILE)"\") (setq org-html-htmlize-output-type 'css) (org-html-export-to-html))"
	$(EMACS) yasnippets.org -Q --batch --eval "(progn (load \""$(HTMLIZE_FILE)"\") (setq org-html-htmlize-output-type 'css) (org-html-export-to-html))"

.PHONY: org-generate
org-generate:
	$(EMACS) -Q -l init.el --batch --eval "(progn (require 'org-generate) (setq org-generate-root \"yasnippets\") (setq org-generate-file (locate-user-emacs-file \"yasnippets.org\")) (org-generate \"yasnippet/default\"))"

$(HTMLIZE_FILE):
	wget $(HTMLIZE_URL)
