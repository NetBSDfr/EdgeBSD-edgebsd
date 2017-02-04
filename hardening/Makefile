# $NetBSD$

PKGNAME=	edgebsd-hardening-${VERSION}
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	Hardening checks for pkgsrc
LICENSE=	modified-bsd

VERSION=	3

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}
MAKE_FLAGS+=	CFLAGS=${CFLAGS:Q}
MAKE_FLAGS+=	LDFLAGS=${LDFLAGS:Q}

do-extract:
	@${CP} -R -- ${FILESDIR} ${WRKSRC}

do-test:
	@cd ${WRKSRC} && ${SETENV} LD_LIBRARY_PATH=${WRKSRC} ./hardening

.include "../../mk/bsd.pkg.mk"
