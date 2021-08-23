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
	$(INSTALL) -m 0644 edgebsd-gueststat $(DESTDIR)$(PREFIX)/sbin/edgebsd-gueststat

uninstall:
	$(RM) -- $(DESTDIR)$(PREFIX)/sbin/edgebsd-gueststat

.PHONY: all clean distclean install uninstall
