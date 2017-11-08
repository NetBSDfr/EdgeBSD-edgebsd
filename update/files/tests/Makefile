TARGETS	= $(OBJDIR)shlint.log
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)shlint.log: shlint.sh
	./shlint.sh -P "$(PREFIX)" -- "$(OBJDIR)shlint.log"

clean:
	$(RM) -- $(shlint.log_OBJS)
	./shlint.sh -c -P "$(PREFIX)" -- "$(OBJDIR)shlint.log"

distclean: clean
	$(RM) -- $(TARGETS)

install: $(TARGETS)

uninstall:

.PHONY: all clean distclean install uninstall
