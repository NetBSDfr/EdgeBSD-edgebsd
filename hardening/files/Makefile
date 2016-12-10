PACKAGE	= Hardening
VERSION	= 1
TARGETS	= $(OBJDIR)libHardening.a $(OBJDIR)libHardening$(SOEXT).0.0 $(OBJDIR)libHardening$(SOEXT).0 $(OBJDIR)libHardening$(SOEXT) $(OBJDIR)hardening$(EXEEXT)
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
LIBDIR	= $(PREFIX)/lib
CC	= cc
CPPFLAGSF=
CPPFLAGS=
CFLAGSF	=
CFLAGS	= -W -Wall -g -O2
LDFLAGS	= 
EXEEXT	=
AR	= ar
RANLIB	= ranlib
CCSHARED= $(CC) -shared
SOEXT	= .so
BINDIR	= $(PREFIX)/bin
SBINDIR	= $(PREFIX)/sbin
RM	= rm -f
LN	= ln -f
TAR	= tar
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

libHardening_OBJS = $(OBJDIR)lib.o
libHardening_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS) -fPIC
libHardening_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)libHardening.a: $(libHardening_OBJS)
	$(AR) -rc $(OBJDIR)libHardening.a $(libHardening_OBJS)
	$(RANLIB) $(OBJDIR)libHardening.a

$(OBJDIR)libHardening$(SOEXT).0.0: $(libHardening_OBJS)
	$(CCSHARED) -o $(OBJDIR)libHardening$(SOEXT).0.0 $(libHardening_OBJS) $(libHardening_LDFLAGS)

$(OBJDIR)libHardening$(SOEXT).0: $(OBJDIR)libHardening$(SOEXT).0.0
	$(LN) -s -- libHardening$(SOEXT).0.0 $(OBJDIR)libHardening$(SOEXT).0

$(OBJDIR)libHardening$(SOEXT): $(OBJDIR)libHardening$(SOEXT).0.0
	$(LN) -s -- libHardening$(SOEXT).0.0 $(OBJDIR)libHardening$(SOEXT)

hardening_OBJS = $(OBJDIR)main.o
hardening_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS) -fPIE
hardening_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -L$(OBJDIR). -lHardening

$(OBJDIR)hardening$(EXEEXT): $(hardening_OBJS) $(OBJDIR)libHardening$(SOEXT)
	$(CC) -o $(OBJDIR)hardening$(EXEEXT) $(hardening_OBJS) $(hardening_LDFLAGS)

$(OBJDIR)lib.o: lib.c lib.h
	$(CC) $(libHardening_CFLAGS) -o $(OBJDIR)lib.o -c lib.c

$(OBJDIR)main.o: main.c lib.h
	$(CC) $(hardening_CFLAGS) -o $(OBJDIR)main.o -c main.c

clean:
	$(RM) -- $(libHardening_OBJS) $(hardening_OBJS)

distclean: clean
	$(RM) -- $(TARGETS)

dist:
	$(RM) -r -- $(OBJDIR)$(PACKAGE)-$(VERSION)
	$(LN) -s -- "$$PWD" $(OBJDIR)$(PACKAGE)-$(VERSION)
	@cd $(OBJDIR). && $(TAR) -czvf $(PACKAGE)-$(VERSION).tar.gz -- \
		$(PACKAGE)-$(VERSION)/lib.c \
		$(PACKAGE)-$(VERSION)/main.c \
		$(PACKAGE)-$(VERSION)/Makefile \
		$(PACKAGE)-$(VERSION)/README.md \
		$(PACKAGE)-$(VERSION)/lib.h \
		$(PACKAGE)-$(VERSION)/project.conf
	$(RM) -- $(OBJDIR)$(PACKAGE)-$(VERSION)

distcheck: dist
	$(TAR) -xzvf $(OBJDIR)$(PACKAGE)-$(VERSION).tar.gz
	$(MKDIR) -- $(PACKAGE)-$(VERSION)/objdir
	$(MKDIR) -- $(PACKAGE)-$(VERSION)/destdir
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/"
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/" DESTDIR="$$PWD/destdir" install
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/" DESTDIR="$$PWD/destdir" uninstall
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) OBJDIR="$$PWD/objdir/" distclean
	cd "$(PACKAGE)-$(VERSION)" && $(MAKE) dist
	$(RM) -r -- $(PACKAGE)-$(VERSION)

install: $(TARGETS)

uninstall:

.PHONY: all clean distclean dist distcheck install uninstall
