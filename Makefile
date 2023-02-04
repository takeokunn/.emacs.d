EMACS ?= emacs

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ~/.emacs.d/.junk/*

.PHONY: link
link:
	ln -nfs $(TOP_DIR) ~/

.PHONY: compile
compile: byte-compile byte-compile-libraries

.PHONY: byte-compile
byte-compile:
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./early-init.org\" \"./early-init.el\" \"emacs-lisp\"))"
	$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"./index.org\" \"./init.el\" \"emacs-lisp\"))"
	$(EMACS) -Q --batch -f batch-byte-compile early-init.el
	$(EMACS) -Q --batch -f batch-byte-compile init.el

.PHONY: byte-compile-libraries
byte-compile-libraries:
	$(EMACS) -Q --batch --eval "(progn (add-to-list 'load-path (locate-user-emacs-file \"elpa/el-clone\")) (require 'el-clone) (el-clone-byte-compile))"
	make -C el-clone/ddskk elc
