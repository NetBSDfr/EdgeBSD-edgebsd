TARGETS	= $(OBJDIR)edgebsd-tls
OBJDIR	=
PREFIX	= /Users/khorben/opt/DeforaOS
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)edgebsd-tls: edgebsd-tls.in ../tools/subst.sh
	../tools/subst.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-tls"

clean:
	../tools/subst.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-tls"

distclean: clean
	$(RM) -- $(TARGETS)

install: all
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/sbin" -i -- "$(OBJDIR)edgebsd-tls"

uninstall:
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/sbin" -u -- "edgebsd-tls"

.PHONY: all clean distclean install uninstall
