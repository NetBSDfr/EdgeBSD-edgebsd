/* $Id$ */
/* Copyright (c) 2016 Pierre Pronchery <khorben@edgebsd.org> */
/* This file is part of EdgeBSD Hardening */
/* Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the authors nor the names of the contributors may be
 *    used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY ITS AUTHORS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */



#include <sys/mman.h>
#include <stdio.h>
#include "lib.h"


/* prototypes */
static unsigned int _executable(void);


/* functions */
/* executable */
static unsigned int _executable(void)
{
	unsigned int ret = 0;
	void * m1;
	void * m2;
	const int mprot = PROT_READ | PROT_WRITE;
#ifdef MAP_ANON
	const int mflags = MAP_ANON;
#else
	const int mflags = MAP_ANONYMOUS;
#endif

	/* check for PIE */
#if defined(__PIE__)
	printf("[+] built with -fPIE, perfect, complete ASLR\n");
#elif defined(__PIC__)
	printf("[+] built with -fPIC, enough for ASLR but not for joerg@\n");
#else
	printf("[-] NOT built with -fPIE or even -fPIC, no complete ASLR\n");
	ret |= 1;
#endif

	/* check for FORTIFY */
#if defined(_FORTIFY_SOURCE) && _FORTIFY_SOURCE > 1
	printf("[+] built with _FORTIFY_SOURCE %u, all good\n",
			_FORTIFY_SOURCE);
#elif defined(_FORTIFY_SOURCE) && _FORTIFY_SOURCE == 1
	printf("[+] built with _FORTIFY_SOURCE %u, consider 2 or more\n",
			_FORTIFY_SOURCE);
#elif defined(_FORTIFY_SOURCE) && _FORTIFY_SOURCE <= 0
	printf("[-] built with _FORTIFY_SOURCE %u, should be 2 or at least 1\n",
			_FORTIFY_SOURCE);
#else
	printf("[-] not built with _FORTIFY_SOURCE at all :(\n");
	ret |= 2;
#endif

#if 1 /* XXX I am not fully sure this check is relevant :( */
	/* check for PaX mprotect */
	m1 = mmap(NULL, BUFSIZ, PROT_READ | PROT_WRITE | PROT_EXEC, mflags,
			-1, 0);
	if(m1 == MAP_FAILED)
		printf("[+] mmap() failed W|X, good\n");
	else
	{
		printf("[-] mmap() failed W^X, not good\n");
		ret |= 4;
	}
	munmap(m1, BUFSIZ);
#endif

#if 1 /* XXX again, I am not fully sure this check is relevant :( */
	/* check for PaX ASLR (mmap) */
	m1 = mmap(NULL, BUFSIZ, mprot, mflags, -1, 0);
	munmap(m1, BUFSIZ);
	m2 = mmap(NULL, BUFSIZ, mprot, mflags, -1, 0);
	munmap(m2, BUFSIZ);
	if(m1 == MAP_FAILED || m2 == MAP_FAILED)
	{
		printf("[-] mmap() failed for some reason :(\n");
		ret |= 8;
	}
	else if(m1 == m2)
	{
		printf("[-] mmap() gave two identical addresses :(\n");
		ret |= 8;
	}
	else
		printf("[+] mmap() gave two differing addresses \\o/\n");
#endif
	return ret;
}


/* main */
int main(void)
{
	int ret;

	/* check the library for hardening */
	ret = (hardening() << 1);
	printf("[!] Hi! I am an executable.\n");

	/* check the executable for hardening */
	ret |= (_executable() << 2);

	return ret;
}
