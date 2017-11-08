PACKAGE	= Hardening
VERSION	= 3
TARGETS	= $(OBJDIR)libHardening.a $(OBJDIR)libHardening$(SOEXT).0.0 $(OBJDIR)libHardening$(SOEXT).0 $(OBJDIR)libHardening$(SOEXT) $(OBJDIR)hardening$(EXEEXT) $(OBJDIR)true$(EXEEXT) $(OBJDIR)true-relro$(EXEEXT) $(OBJDIR)true-relro-now$(EXEEXT)
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
LIBDIR	= $(PREFIX)/lib
CC	= cc
CPPFLAGSF=
CPPFLAGS=
CFLAGSF	=
CFLAGS	= -g
LDFLAGS	= 
EXEEXT	=
AR	= ar
ARFLAGS	= -rc
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
	$(AR) $(ARFLAGS) $(OBJDIR)libHardening.a $(libHardening_OBJS)
	$(RANLIB) $(OBJDIR)libHardening.a

$(OBJDIR)libHardening$(SOEXT).0.0: $(libHardening_OBJS)
	$(CCSHARED) -o $(OBJDIR)libHardening$(SOEXT).0.0 -Wl,-soname,libHardening$(SOEXT).0 $(libHardening_OBJS) $(libHardening_LDFLAGS)

$(OBJDIR)libHardening$(SOEXT).0: $(OBJDIR)libHardening$(SOEXT).0.0
	$(LN) -s -- libHardening$(SOEXT).0.0 $(OBJDIR)libHardening$(SOEXT).0

$(OBJDIR)libHardening$(SOEXT): $(OBJDIR)libHardening$(SOEXT).0.0
	$(LN) -s -- libHardening$(SOEXT).0.0 $(OBJDIR)libHardening$(SOEXT)

hardening_OBJS = $(OBJDIR)hardening.o
hardening_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
hardening_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -L$(OBJDIR). -lHardening

$(OBJDIR)hardening$(EXEEXT): $(hardening_OBJS) $(OBJDIR)libHardening$(SOEXT)
	$(CC) -o $(OBJDIR)hardening$(EXEEXT) $(hardening_OBJS) $(hardening_LDFLAGS)

true_OBJS = $(OBJDIR)true.o
true_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
true_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)true$(EXEEXT): $(true_OBJS)
	$(CC) -o $(OBJDIR)true$(EXEEXT) $(true_OBJS) $(true_LDFLAGS)

true-relro_OBJS = $(OBJDIR)true-relro.o
true-relro_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
true-relro_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -Wl,-z,relro

$(OBJDIR)true-relro$(EXEEXT): $(true-relro_OBJS)
	$(CC) -o $(OBJDIR)true-relro$(EXEEXT) $(true-relro_OBJS) $(true-relro_LDFLAGS)

true-relro-now_OBJS = $(OBJDIR)true-relro-now.o
true-relro-now_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
true-relro-now_LDFLAGS = $(LDFLAGSF) $(LDFLAGS) -Wl,-z,relro -Wl,-z,now

$(OBJDIR)true-relro-now$(EXEEXT): $(true-relro-now_OBJS)
	$(CC) -o $(OBJDIR)true-relro-now$(EXEEXT) $(true-relro-now_OBJS) $(true-relro-now_LDFLAGS)

$(OBJDIR)lib.o: lib.c lib.h
	$(CC) $(libHardening_CFLAGS) -o $(OBJDIR)lib.o -c lib.c

$(OBJDIR)hardening.o: hardening.c lib.h
	$(CC) $(hardening_CFLAGS) -o $(OBJDIR)hardening.o -c hardening.c

$(OBJDIR)true.o: true.c
	$(CC) $(true_CFLAGS) -o $(OBJDIR)true.o -c true.c

$(OBJDIR)true-relro.o: true-relro.c
	$(CC) $(true-relro_CFLAGS) -o $(OBJDIR)true-relro.o -c true-relro.c

$(OBJDIR)true-relro-now.o: true-relro-now.c
	$(CC) $(true-relro-now_CFLAGS) -o $(OBJDIR)true-relro-now.o -c true-relro-now.c

clean:
	$(RM) -- $(libHardening_OBJS) $(hardening_OBJS) $(true_OBJS) $(true-relro_OBJS) $(true-relro-now_OBJS)

distclean: clean
	$(RM) -- $(TARGETS)

dist:
	$(RM) -r -- $(OBJDIR)$(PACKAGE)-$(VERSION)
	$(LN) -s -- "$$PWD" $(OBJDIR)$(PACKAGE)-$(VERSION)
	@cd $(OBJDIR). && $(TAR) -czvf $(PACKAGE)-$(VERSION).tar.gz -- \
		$(PACKAGE)-$(VERSION)/lib.c \
		$(PACKAGE)-$(VERSION)/hardening.c \
		$(PACKAGE)-$(VERSION)/true.c \
		$(PACKAGE)-$(VERSION)/true-relro.c \
		$(PACKAGE)-$(VERSION)/true-relro-now.c \
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
	$(MKDIR) $(DESTDIR)$(LIBDIR)
	$(INSTALL) -m 0644 $(OBJDIR)libHardening.a $(DESTDIR)$(LIBDIR)/libHardening.a
	$(INSTALL) -m 0755 $(OBJDIR)libHardening$(SOEXT).0.0 $(DESTDIR)$(LIBDIR)/libHardening$(SOEXT).0.0
	$(LN) -s -- libHardening$(SOEXT).0.0 $(DESTDIR)$(LIBDIR)/libHardening$(SOEXT).0
	$(LN) -s -- libHardening$(SOEXT).0.0 $(DESTDIR)$(LIBDIR)/libHardening$(SOEXT)
	$(MKDIR) $(DESTDIR)$(BINDIR)
	$(INSTALL) -m 0755 $(OBJDIR)hardening$(EXEEXT) $(DESTDIR)$(BINDIR)/hardening$(EXEEXT)

uninstall:
	$(RM) -- $(DESTDIR)$(LIBDIR)/libHardening.a
	$(RM) -- $(DESTDIR)$(LIBDIR)/libHardening$(SOEXT).0.0
	$(RM) -- $(DESTDIR)$(LIBDIR)/libHardening$(SOEXT).0
	$(RM) -- $(DESTDIR)$(LIBDIR)/libHardening$(SOEXT)
	$(RM) -- $(DESTDIR)$(BINDIR)/hardening$(EXEEXT)

.PHONY: all clean distclean dist distcheck install uninstall
