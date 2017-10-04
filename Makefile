# Makefile for applysys

VERSION = $$(git describe --tags| sed 's/-.*//g;s/^v//;')
PKGNAME = applysys

BINDIR = /usr/bin

SCRIPTS = applysys.in
MANPAGES = doc/applysys.1
		
all: doc

install: all
	
	sed -i 's,@BINDIR@,$(BINDIR),' $(SCRIPTS)
		
	install -Dm 0755 applysys.in $(DESTDIR)/usr/bin/applysys
		
	install -Dm 0644 applysys.hook $(DESTDIR)/usr/share/libalpm/hooks/applysys.hook; \
		
	install -Dm644 doc/applysys.1 $(DESTDIR)/usr/share/man/man1/applysys.1
		
	install -Dm644 LICENSE $(DESTDIR)/usr/share/licenses/$(PKGNAME)/LICENSE

doc: $(MANPAGES)
doc/%: doc/%.txt Makefile
	a2x -d manpage \
		-f manpage \
		-a manversion=$(VERSION) \
		-a manmanual="applysys manual" $<
		
version:
	@echo $(VERSION)
	
.PHONY: install version doc
