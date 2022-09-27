TARGETS	= $(OBJDIR)edgebsd-qemu $(OBJDIR)nvmm-xl
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)edgebsd-qemu: edgebsd-qemu.in ../tools/subst.sh
	../tools/subst.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-qemu"

$(OBJDIR)nvmm-xl: nvmm-xl.in ../tools/subst.sh
	../tools/subst.sh -P "$(PREFIX)" -- "$(OBJDIR)nvmm-xl"

clean:
	../tools/subst.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-qemu"
	../tools/subst.sh -c -P "$(PREFIX)" -- "$(OBJDIR)nvmm-xl"

distclean: clean
	$(RM) -- $(TARGETS)

install: all
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/libexec/EdgeBSD/edgebsd-nvmm" -i -- "$(OBJDIR)edgebsd-qemu"
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/sbin" -i -- "$(OBJDIR)nvmm-xl"

uninstall:
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/libexec/EdgeBSD/edgebsd-nvmm" -u -- "edgebsd-qemu"
	../tools/subst.sh -P "$(DESTDIR)$(PREFIX)/sbin" -u -- "nvmm-xl"

.PHONY: all clean distclean install uninstall
