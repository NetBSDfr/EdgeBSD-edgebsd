#!/bin/sh
#$Id$
#Copyright (c) 2021 Pierre Pronchery <khorben@defora.org>
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



#variables
PROGNAME="tests.sh"
#executables
DATE="date"
DEBUG="_debug"
EDGEBSD_TLS="../src/edgebsd-tls"
MKTEMP="mktemp"
RM="/bin/rm -f"


#functions
#tests
_tests()
{
	ret=0

	$DATE
	echo
	_tests_renew "renewal"					|| ret=2
	_tests_usage "usage"					|| ret=2
	return $ret
}

_tests_renew()
{
	test="$1"

	echo "$PROGNAME: Testing $test"
	tmpdir=$($DEBUG $MKTEMP -d)
	[ $? -eq 0 ] || return 2

	$DEBUG $EDGEBSD_TLS renew -av \
		-O ACMEDIR="$tmpdir/acme" \
		-O ACME="/bin/echo" \
		-O BASEDIR="$tmpdir/basedir" \
		-O RENEW_HOSTS="www.example.com" \
		-O RENEW_SERVICES="example-service test-service" \
		-O SERVICE="/bin/echo" 2>&1
	res=$?
	$DEBUG $RM -r -- "$tmpdir"
	if [ $res -eq 0 ]; then
		echo "$PROGNAME: $test: OK"
		return 0
	else
		echo "$PROGNAME: $test: FAIL"
		return 2
	fi
}

_tests_usage()
{
	test="$1"

	echo "$PROGNAME: Testing $test"
	$DEBUG $EDGEBSD_TLS -? 2>&1
	if [ $? -eq 1 ]; then
		echo "$PROGNAME: $test: OK"
		return 0
	else
		echo "$PROGNAME: $test: FAIL"
		return 2
	fi
}


#debug
_debug()
{(
	echo "$@" 1>&3
	"$@"
	res=$?
	#ignore errors when the command is not available
	[ $res -eq 127 ]					&& return 0
	return $res
)}


#usage
_usage()
{
	echo "Usage: $PROGNAME [-c] target..." 1>&2
	return 1
}


#warning
_warning()
{
	echo "$PROGNAME: $@" 1>&2
	return 2
}


#main
clean=0
while getopts "cO:P:" name; do
	case "$name" in
		c)
			clean=1
			;;
		O)
			export "${OPTARG%%=*}"="${OPTARG#*=}"
			;;
		P)
			#XXX ignored for compatibility
			;;
		?)
			_usage
			exit $?
			;;
	esac
done
shift $((OPTIND - 1))
if [ $# -lt 1 ]; then
	_usage
	exit $?
fi

#clean
[ $clean -ne 0 ] && exit 0

exec 3>&1
while [ $# -gt 0 ]; do
	target="$1"
	shift

	_tests > "$target"					|| exit 2
done
