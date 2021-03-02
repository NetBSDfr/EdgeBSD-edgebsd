TARGETS	= $(OBJDIR)nvmm-xl.8 $(OBJDIR)nvmm-xl.html
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)nvmm-xl.8: docbook.sh nvmm-xl.xml
	./docbook.sh -P "$(PREFIX)" -- "$(OBJDIR)nvmm-xl.8"

$(OBJDIR)nvmm-xl.html: docbook.sh nvmm-xl.css.xml nvmm-xl.xml manual.css.xml
	./docbook.sh -P "$(PREFIX)" -- "$(OBJDIR)nvmm-xl.html"

clean:
	./docbook.sh -c -P "$(PREFIX)" -- "$(OBJDIR)nvmm-xl.8"
	./docbook.sh -c -P "$(PREFIX)" -- "$(OBJDIR)nvmm-xl.html"

distclean: clean
	$(RM) -- $(TARGETS)

install: all
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -i -- "$(OBJDIR)nvmm-xl.8"
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -i -- "$(OBJDIR)nvmm-xl.html"

uninstall:
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -u -- "nvmm-xl.8"
	./docbook.sh -P "$(DESTDIR)$(PREFIX)" -u -- "nvmm-xl.html"

.PHONY: all clean distclean install uninstall
