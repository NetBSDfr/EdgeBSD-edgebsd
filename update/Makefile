# $NetBSD$

PKGNAME=	edgebsd-update-${VERSION}
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	Update script for EdgeBSD
LICENSE=	modified-bsd

VERSION=	2

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

do-extract:
	@${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../mk/bsd.pkg.mk"
