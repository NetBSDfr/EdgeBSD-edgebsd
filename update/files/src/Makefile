TARGETS	= $(OBJDIR)edgebsd-update
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)edgebsd-update: edgebsd-update.in ../tools/subst.sh
	../tools/subst.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-update"

clean:
	../tools/subst.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-update"

distclean: clean
	$(RM) -- $(TARGETS)

install: all
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/sbin" -i -- "$(OBJDIR)edgebsd-update"

uninstall:
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/sbin" -u -- "edgebsd-update"

.PHONY: all clean distclean install uninstall
