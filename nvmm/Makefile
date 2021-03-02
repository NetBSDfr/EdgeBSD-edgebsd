# $NetBSD$

PKGNAME=	edgebsd-nvmm-${VERSION}
VERSION=	9
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	NVMM support for EdgeBSD
LICENSE=	modified-bsd

ONLY_FOR_PLATFORM=	NetBSD-*-x86_64

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

RCD_SCRIPTS=	nvmmdomains
FILES_SUBST+=	PKG_SYSCONFDIR=${PKG_SYSCONFDIR}
FILES_SUBST+=	PREFIX=${PREFIX}

TEST_TARGET=	tests

DEPENDS+=	qemu-[0-9]*:../../emulators/qemu
DEPENDS+=	screen-[0-9]*:../../misc/screen

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../mk/bsd.pkg.mk"
