# $NetBSD$

PKGNAME=	edgebsd-update-${VERSION}
PKGREVISION=	5
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	Update script for EdgeBSD
LICENSE=	modified-bsd

VERSION=	9

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	@${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../mk/bsd.pkg.mk"
