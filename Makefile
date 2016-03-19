prefix ?= /usr/

all: podget podget.7.gz changelog.gz

podget.7.gz: DOC/podget.7
	gzip -9 < $< > DOC/$@

changelog.gz: Changelog
	gzip -9 < $< > $@

install: all
	mkdir -p $(DESTDIR)$(prefix)/bin/
	install -m 755 podget $(DESTDIR)$(prefix)/bin/podget

	mkdir -p $(DESTDIR)$(prefix)/share/man/man7/
	install -m 644 DOC/podget.7.gz $(DESTDIR)$(prefix)/share/man/man7/podget.7.gz

	mkdir -p $(DESTDIR)$(prefix)/share/doc/podget
	install -m 444 changelog.gz $(DESTDIR)$(prefix)/share/doc/podget/changelog.gz

distclean: clean
clean:
	rm -f DOC/podget.7.gz
	rm -f changelog.gz
