# $NetBSD$

PKGNAME=	edgebsd-nvmm-${VERSION}
VERSION=	9
PKGREVISION=	13
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	NVMM support for EdgeBSD
LICENSE=	modified-bsd

ONLY_FOR_PLATFORM=	NetBSD-*-*

MAKE_FLAGS+=	DESTDIR=${DESTDIR:Q}
MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

RCD_SCRIPTS=	nvmmdomains
FILES_SUBST+=	PKG_SYSCONFDIR=${PKG_SYSCONFDIR}
FILES_SUBST+=	PREFIX=${PREFIX}

TEST_TARGET=	tests

DEPENDS+=	qemu-[0-9]*:../../emulators/qemu
DEPENDS+=	screen-[0-9]*:../../misc/screen

EGDIR=		share/examples/edgebsd-nvmm
CONF_FILES=	${EGDIR}/template.netbsd.amd64 \
		${PKG_SYSCONFDIR}/EdgeBSD/edgebsd-nvmm/hosts/template.netbsd.amd64
INSTALLATION_DIRS+=	${EGDIR}

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	${CP} -R -- ${FILESDIR} ${WRKSRC}

post-install:
	${MV} ${DESTDIR}${PREFIX}/share/doc/edgebsd-nvmm/template.netbsd.amd64 \
		${DESTDIR}${PREFIX}/${EGDIR}

.include "../../mk/bsd.pkg.mk"
