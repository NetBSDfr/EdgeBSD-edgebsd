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
	$(INSTALL) -m 0755 nvmm-xl $(DESTDIR)$(PREFIX)/sbin/nvmm-xl

uninstall:
	$(RM) -- $(DESTDIR)$(PREFIX)/sbin/nvmm-xl

.PHONY: all clean distclean install uninstall
