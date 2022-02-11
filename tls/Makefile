# $NetBSD$

PKGNAME=	edgebsd-tls-${VERSION}
VERSION=	9
PKGREVISION=	6
CATEGORIES=	edgebsd

MAINTAINER=	khorben@edgebsd.org
HOMEPAGE=	https://www.edgebsd.org/
COMMENT=	TLS certificate management for EdgeBSD
LICENSE=	modified-bsd

EGDIR=		share/doc/edgebsd-tls
CONF_FILES=	${EGDIR}/openssl.cnf ${PKG_SYSCONFDIR}/openssl.cnf
PKG_SYSCONFSUBDIR=EdgeBSD/edgebsd-tls

MAKE_FLAGS+=	PREFIX=${PREFIX:Q}
MAKE_FLAGS+=	PYVERSSUFFIX=${PYVERSSUFFIX:Q}

TEST_TARGET=	tests

DEPENDS+=	mozilla-rootcerts-[0-9]*:../../security/mozilla-rootcerts
DEPENDS+=	${PYPKGPREFIX}-acme-tiny-[0-9]*:../../security/py-acme-tiny

USE_TOOLS+=	grep
USE_TOOLS+=	sed

.include "../../mk/bsd.prefs.mk"

.if ${PKGMANDIR} != "share/man"
MAKE_FLAGS+=	MANDIR=${DESTDIR:Q}${PREFIX:Q}/${PKGMANDIR:Q}
.endif

do-extract:
	${CP} -R -- ${FILESDIR} ${WRKSRC}

.include "../../lang/python/pyversion.mk"
.include "../../mk/bsd.pkg.mk"
