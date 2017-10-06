#!/bin/sh

# soft-off program
# This program uses OpenWRT/LEDE's sysupgrade functionality to get
# a device into a "soft-off" state. This is because not all devices
# do have a working "poweroff" and if a user wants to unplug the 
# device in order to move it. she/he might want this functionality.

# Currently, this script tries to put all attached harddrives into
# standby mode (which is why it requires hdparm) and tries to powers
# off all LEDs.

. /lib/functions.sh
. /lib/functions/system.sh
. /lib/upgrade/common.sh

HDPARM=$(command -v hdparm)

[ -z "$HDPARM" ] && {
	(>&2 echo hdparm not installed.)
	exit 1
}

case "$1" in
stage2)
	for dev in /dev/sd*[a-z]; do
		hdparm -y $dev
	done

	for leds in /sys/class/leds/*; do
		echo 0 > $leds/brightness
	done

	while :; do
		sleep 10000;
	done
	;;
*)
	install_bin /sbin/upgraded
	install_bin $0
	install_bin /sbin/hdparm

	ifdown -a

	ubus call system sysupgrade "{
		\"prefix\": $(json_string "$RAM_ROOT"),
		\"path\": $(json_string "badfile"),
		\"command\": $(json_string "$0 stage2")
	}"
	;;
esac
