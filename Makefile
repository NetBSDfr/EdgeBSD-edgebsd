# $NetBSD$

COMMENT=	Packages for pkgsrc from EdgeBSD

#SUBDIR+=	.git # to silence pkglint
SUBDIR+=	hardening
SUBDIR+=	nvmm
SUBDIR+=	tls
SUBDIR+=	update

${.CURDIR}/PKGDB:
	${RM} -f ${.CURDIR}/PKGDB
	${ECHO_MSG} "Extracting complete dependency database.  This may take a while..."
	DB=${.CURDIR}/PKGDB ; \
	PKGSRCDIR=${.CURDIR} ; \
	npkg=1; \
	list=`${GREP} '^[[:space:]]*'SUBDIR Makefile | ${SED} 's,.*=[[:space:]]*,,'` ; \
	for pkgdir in $$list ; do \
		if [ ! -d $$pkgdir ]; then  \
			${ECHO} " " ; \
			${ECHO} "WARNING:  the package directory $$pkgdir is listed in" > /dev/stderr ; \
			${ECHO} $$pkgdir | ${SED} 's;/.*;/Makefile;g' > /dev/stderr ; \
			${ECHO} "but the directory does not exist.  Please fix this!" > /dev/stderr ; \
		else \
			cd $$pkgdir ; \
			l=`${MAKE} print-summary-data`  ; \
			if [ $$? != 0 ]; then \
				${ECHO} "WARNING (printdepends):  the package in $$pkgdir had problem with" \
					> /dev/stderr ; \
				${ECHO} "    ${MAKE} print-summary-data" > /dev/stderr ; \
				${ECHO} "    database information for this package" > /dev/stderr ; \
				${ECHO} "    will be dropped." > /dev/stderr ; \
				${MAKE} print-summary-data  2>&1 > /dev/stderr ; \
			else \
				${ECHO} "$$l" >> $$DB ; \
			fi ; \
		fi ; \
		${ECHO_N} "." ; \
		if [ `${EXPR} $$npkg % 100 = 0` -eq 1 ]; then \
			${ECHO} " " ; \
			${ECHO} "$$npkg" ; \
		fi ; \
		npkg=`${EXPR} $$npkg + 1` ; \
		cd $$PKGSRCDIR  ; \
	done

.PHONY: index
index: ${.CURDIR}/INDEX

${.CURDIR}/INDEX: ${.CURDIR}/PKGDB
	${RM} -f ${.CURDIR}/INDEX
	${AWK} -f ../mk/scripts/genindex.awk PKGSRCDIR=${.CURDIR} SORT=${SORT:Q} ${.CURDIR}/PKGDB
	${RM} -f ${.CURDIR}/PKGDB
	${GREP} -v '||||||||||$$' ${.CURDIR}/INDEX > ${.CURDIR}/INDEX.tmp && \
		${MV} ${.CURDIR}/INDEX.tmp ${.CURDIR}/INDEX

.include "../mk/misc/category.mk"
