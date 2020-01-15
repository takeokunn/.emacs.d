EMACS ?= emacs
TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: install
install:
	cask install

.PHONY: update
update:
	cask update

.PHONY: clean
clean:
	rm -f  ~/.emacs.d/.junk/*

.PHONY: link
link:
	ln -nfs $(TOP_DIR) ~/.emacs.d

.PHONY: compile
compile:
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./index.org\" \"./index.el\" \"emacs-lisp\") (byte-compile-file \"./index.el\"))"
