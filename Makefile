EMACS ?= emacs

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ~/.emacs.d/.junk/*

.PHONY: link
link:
	mkdir -p $HOME/.config/emacs
	ln -nfs $(TOP_DIR) ~/.config/emacs

.PHONY: byte-compile
byte-compile:
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./early-init.org\" \"./early-init.el\" \"emacs-lisp\"))"
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./index.org\" \"./init.el\" \"emacs-lisp\"))"
	$(EMACS) -Q --batch -f batch-byte-compile early-init.el
	$(EMACS) -Q --batch -f batch-byte-compile init.el
