# $NetBSD$

PKGNAME=	edgebsd-update-${VERSION}
VERSION=	9
PKGREVISION=	23
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	Update script for EdgeBSD
LICENSE=	modified-bsd

TOOL_DEPENDS+=	libxslt-[0-9]*:../../textproc/libxslt
BUILD_DEPENDS+=	docbook-xsl-[0-9]*:../../textproc/docbook-xsl

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}

RCD_SCRIPTS=	edgebsd-update

TEST_TARGET=	tests

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../mk/bsd.pkg.mk"
