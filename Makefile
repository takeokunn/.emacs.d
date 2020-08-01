EMACS ?= emacs
TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: all
all: compile org-to-html

.PHONY: install
install: link cask-install cask-update

.PHONY: cask-install
cask-install:
	cask install

.PHONY: cask-update
cask-update:
	cask update

.PHONY: clean
clean:
	rm -f  ~/.emacs.d/.junk/*

.PHONY: link
link:
	ln -nfs $(TOP_DIR) ~/.emacs.d

.PHONY: compile
compile:
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./index.org\" \"./index.el\" \"emacs-lisp\"))"
	$(EMACS) -Q --batch -f batch-byte-compile "./index.el"

.PHONY: org-to-html
org-to-html:
	$(EMACS) index.org -Q --batch --eval "(progn (setq org-html-htmlize-output-type nil) (org-html-export-to-html))"
