TARGETS	= $(OBJDIR)edgebsd-update.8 $(OBJDIR)edgebsd-update.html
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)edgebsd-update.8: docbook.sh edgebsd-update.xml
	./docbook.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-update.8"

$(OBJDIR)edgebsd-update.html: docbook.sh edgebsd-update.css.xml edgebsd-update.xml manual.css.xml
	./docbook.sh -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-update.html"

clean:
	$(RM) -- $(edgebsd-update.8_OBJS) $(edgebsd-update.html_OBJS)
	./docbook.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-update.8"
	./docbook.sh -c -P "$(PREFIX)" -- "$(OBJDIR)edgebsd-update.html"

distclean: clean
	$(RM) -- $(TARGETS)

install: all
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -i -- "$(OBJDIR)edgebsd-update.8"
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -i -- "$(OBJDIR)edgebsd-update.html"

uninstall:
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -u -- "edgebsd-update.8"
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -u -- "edgebsd-update.html"

.PHONY: all clean distclean install uninstall
