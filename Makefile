TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

install:
	cask install

update:
	cask update

clean:
	rm -f  ~/.emacs.d/.junk/*

link:
	ln -nfs $(TOP_DIR) ~/.emacs.d
