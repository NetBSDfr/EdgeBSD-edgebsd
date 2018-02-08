OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
MKDIR	= mkdir -m 0755 -p
INSTALL	= install
RM	= rm -f


all:

clean:

distclean: clean

install: all
	$(MKDIR) $(DESTDIR)$(PREFIX)/sbin
	$(INSTALL) -m 0755 edgebsd-update $(DESTDIR)$(PREFIX)/sbin/edgebsd-update

uninstall:
	$(RM) -- $(DESTDIR)$(PREFIX)/sbin/edgebsd-update

.PHONY: all clean distclean install uninstall
