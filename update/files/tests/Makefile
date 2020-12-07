TARGETS	= $(OBJDIR)fixme.log $(OBJDIR)shlint.log $(OBJDIR)tests.log
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all:

$(OBJDIR)fixme.log: fixme.sh
	./fixme.sh -P "$(PREFIX)" -- "$(OBJDIR)fixme.log"

$(OBJDIR)shlint.log: shlint.sh
	./shlint.sh -P "$(PREFIX)" -- "$(OBJDIR)shlint.log"

$(OBJDIR)tests.log: ./tests.sh
	./tests.sh -P "$(PREFIX)" -- "$(OBJDIR)tests.log"

clean:
	./fixme.sh -c -P "$(PREFIX)" -- "$(OBJDIR)fixme.log"
	./shlint.sh -c -P "$(PREFIX)" -- "$(OBJDIR)shlint.log"
	./tests.sh -c -P "$(PREFIX)" -- "$(OBJDIR)tests.log"

distclean: clean
	$(RM) -- $(TARGETS)

install: all

uninstall:

.PHONY: all clean distclean install uninstall
