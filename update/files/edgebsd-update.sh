#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD$
#

# PROVIDE: edgebsd-update
# REQUIRE: mountcritremote
# BEFORE: SERVERS

$_rc_subr_loaded . @SYSCONFBASE@/rc.subr

name="edgebsd-update"
rcvar="edgebsd_update"
command="@PREFIX@/sbin/$name"
start_cmd="edgebsd_update_start"
stop_cmd=":"
extra_commands="clean fetch"
edgebsd_update_cachedir="/var/cache/$name"
edgebsd_update_flags="-v"
required_dirs="$edgebsd_update_cachedir"

clean_cmd="edgebsd_update_clean"
fetch_cmd="edgebsd_update_fetch"

edgebsd_update_clean()
{
	rm -fr "$edgebsd_update_cachedir/pub"
}

edgebsd_update_fetch()
{
	EDGEBSD_RELEASE=$(uname -r | cut -d '.' -f 1)
	EDGEBSD_ARCH_FULL=$(uname -m)
	case "$EDGEBSD_ARCH_FULL" in
		evbarm)
			EDGEBSD_ARCH_FULL="$EDGEBSD_ARCH_FULL-$(uname -p)"
			;;
	esac
	EDGEBSD_PATH="pub/EdgeBSD/EdgeBSD-$EDGEBSD_RELEASE/$EDGEBSD_ARCH_FULL/binary/sets"

	mkdir -p "$edgebsd_update_cachedir/$EDGEBSD_PATH" &&
		cd "$edgebsd_update_cachedir/$EDGEBSD_PATH" &&
		$command -I -n $edgebsd_update_flags
}

edgebsd_update_start()
{
	[ ! -d "$edgebsd_update_cachedir" ] ||
		$command -I -M "$edgebsd_update_cachedir" $edgebsd_update_flags
}

load_rc_config $name
run_rc_command "$1"
