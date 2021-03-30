#!@RCD_SCRIPTS_SHELL@
#
# PROVIDE: nvmmdomains
# REQUIRE: DAEMON
# KEYWORD: shutdown
#
# nvmmdomains		This required variable is a whitespace-separated
#			list of domains, e.g., nvmmdomains="dom1 dom2 dom3".
#
# nvmmdomains_chrootdir	This optional variable is a path to a directory to run
#			qemu in a chroot.
#
# nvmmdomains_config	This optional variable is a format string that
#			represents the path to the configuration file for
#			each domain.  "%s" is substituted with the name of
#			the domain. The default is "@PKG_SYSCONFDIR@/nvmm/%s".
#
# nvmmdomains_prehook	This optional variable is a format string that
#			represents the command to run, if it exists, before
#			starting each domain.  "%s" is substituted with the
#			name of the domain.  The default is
#			"@PKG_SYSCONFDIR@/nvmm/%s-pre".
#
# nvmmdomains_posthook	This optional variable is a format string that
#			represents the command to run, if it exists, after
#			stopping each domain.  "%s" is substituted with the
#			name of the domain.  The default is
#			"@PKG_SYSCONFDIR@/nvmm/%s-post".
#
# nvmmdomains_user	This optional variable is a username for qemu to drop
#			privileges to.
#

$_rc_subr_loaded . /etc/rc.subr

name="nvmmdomains"
ctl_command="@PREFIX@/sbin/nvmm-xl"
start_cmd="nvmmdomains_start"
stop_cmd="nvmmdomains_stop"
list_cmd="nvmmdomains_list"
extra_commands="list"
required_files="/usr/sbin/nvmmctl $ctl_command"

nvmmdomains_start()
{
	[ -n "$nvmmdomains" ] || return

	echo "Starting NVMM domains."
	for domain in $nvmmdomains; do
		case "$domain" in
		"")	continue ;;
		esac

		# Start off by running the pre-hook script if it's present.
		if [ -n "${nvmmdomains_prehook}" ]; then
			cmdline=`printf "${nvmmdomains_prehook}" $domain`
			cmd="${cmdline%% *}"
			if [ -x "$cmd" ]; then
				if ! $cmdline; then
					echo "Pre-hook \`\`$cmdline'' failed... skipping $domain."
					continue
				fi
			fi
		fi

		# Create the domain.
		if [ -n "${nvmmdomains_config}" ]; then
			file=`printf "${nvmmdomains_config}" $domain`
			if [ -f "$file" ]; then
				${ctl_command} create \
					-O CHROOTDIR="$nvmmdomains_chrootdir" \
					-O RUNAS="$nvmmdomains_user" \
					"$file"
			fi
		fi
	done
}

nvmmdomains_list()
{
	# Output a whitespace-separated list of live guest domains.
	${ctl_command} list | awk '
		(FNR <= 2) { next }
		($5 !~ /s/) { s = s " " $1 }
		END { sub(" *", "", s); print s }'
}

nvmmdomains_stop()
{
	# Determine an appropriate timeout waiting for all domains to
	# stop -- always wait at least 60s, and add 5s per active domain.
	#
	numdomains=$(nvmmdomains_list | awk '{ print NF }')
	[ $numdomains -gt 0 ] || return
	timeout=$((60 + numdomains * 5))

	# Stop every NVMM domain, and poll domains every 10s up to the
	# timeout period to check if all of them are stopped.
	#
	echo "Stopping NVMM domains."
	for domain in $(nvmmdomains_list); do
		${ctl_command} shutdown -F $domain
	done
	while [ $timeout -gt 0 ]; do
		livedomains=$(nvmmdomains_list)
		[ -n "$livedomains" ] || break
		timeout=$((timeout - 10))
		sleep 10
	done
	livedomains=$(nvmmdomains_list)
	if [ -n "$livedomains" ]; then
		echo "Failed to stop: $livedomains"
	else
		echo "All domains stopped."
	fi

	# Finish off by running the post-hook script if it's present.
	for domain in $nvmmdomains; do
		case "$domain" in
		"")	continue ;;
		esac
		if [ -n "${nvmmdomains_posthook}" ]; then
			cmdline=`printf "${nvmmdomains_posthook}" $domain`
			cmd="${cmdline%% *}"
			if [ -x "$cmd" ]; then
				$cmdline || echo "Post-hook \`\`$cmdline'' failed."
			fi
		fi
	done
}

load_rc_config $name

: ${nvmmdomains_config="@PKG_SYSCONFDIR@/nvmm/%s"}
: ${nvmmdomains_prehook="@PKG_SYSCONFDIR@/nvmm/%s-pre"}
: ${nvmmdomains_posthook="@PKG_SYSCONFDIR@/nvmm/%s-post"}

run_rc_command "$1"
