# $NetBSD$

PKGNAME=	edgebsd-update-${VERSION}
VERSION=	9
PKGREVISION=	10
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	Update script for EdgeBSD
LICENSE=	modified-bsd

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../mk/bsd.pkg.mk"
