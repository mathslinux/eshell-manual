# package.el multi-file package install

# These are the variables that are specific to the package
NAME=eshell-info
VERSION=0.0.1
DOC="A manual for eshell."

# Everything beyond here should be generic
REQUIREMENTS=requirements.txt
package_parts = $(shell cat build-parts.txt)
PACKAGE=$(NAME)-$(VERSION)
TARBALL=$(PACKAGE).tar 

all: tarball


# Really would like this to clean the elc files of the package_parts
clean-elc:
	rm -f *.elc

clean: clean-elc
	rm -rf .elpa
	rm -rf $(TARBALL)
	rm -rf $(PACKAGE) 
	rm -rf $(NAME)-pkg.el
	rm -rf README

tarball: $(TARBALL)

$(TARBALL): $(PACKAGE) $(PACKAGE)/$(NAME)-pkg.el
	tar cf $@ $<

$(PACKAGE): $(package_parts)
	mkdir $@
	cp $(package_parts) $@

$(PACKAGE)/$(NAME)-pkg.el:
	echo "(define-package \"$(NAME)\" \"$(VERSION)\" \"$(DOC)\" `cat $(REQUIREMENTS)`)" > $@

README:
	cat README.creole > README

# End
