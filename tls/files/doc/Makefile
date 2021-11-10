OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
MKDIR	= mkdir -m 0755 -p
INSTALL	= install
RM	= rm -f
TARGETS	= $(OBJDIR)edgebsd-tls.8 $(OBJDIR)edgebsd-tls.html
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)edgebsd-tls.8: docbook.sh edgebsd-tls.xml
	./docbook.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-tls.8"

$(OBJDIR)edgebsd-tls.html: docbook.sh edgebsd-tls.css.xml edgebsd-tls.xml manual.css.xml
	./docbook.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-tls.html"

clean:
	./docbook.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-tls.8"
	./docbook.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-tls.html"

distclean: clean
	$(RM) -- $(TARGETS)

install: all
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -i -- "$(OBJDIR)edgebsd-tls.8"
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -i -- "$(OBJDIR)edgebsd-tls.html"
	$(MKDIR) $(DESTDIR)$(PREFIX)/share/doc/edgebsd-tls
	$(INSTALL) -m 0644 openssl.cnf $(DESTDIR)$(PREFIX)/share/doc/edgebsd-tls/openssl.cnf

uninstall:
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -u -- "edgebsd-tls.8"
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -u -- "edgebsd-tls.html"
	$(RM) -- $(DESTDIR)$(PREFIX)/share/doc/edgebsd-tls/openssl.cnf

.PHONY: all clean distclean install uninstall
