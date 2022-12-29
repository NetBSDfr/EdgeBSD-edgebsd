#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD$
#

# PROVIDE: edgebsd-update
# REQUIRE: mountcritremote
# BEFORE: SERVERS

$_rc_subr_loaded . @SYSCONFBASE@/rc.subr

name="edgebsd-update"
start_cmd="edgebsd_update_start"
stop_cmd=":"

edgebsd_update_start()
{
	EDGEBSD_UPDATE="@PREFIX@/sbin/edgebsd-update -I"
	EDGEBSD_MIRROR="/var/cache/edgebsd-update"

	[ ! -d "$EDGEBSD_MIRROR" ] || $EDGEBSD_UPDATE $edgebsd_update_flags -M "$EDGEBSD_MIRROR"
}

load_rc_config $name
run_rc_command "$1"
