# $NetBSD$

PKGNAME=	edgebsd-tls-${VERSION}
VERSION=	9
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	TLS certificate management for EdgeBSD
LICENSE=	modified-bsd

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

TEST_TARGET=	tests

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../mk/bsd.pkg.mk"
