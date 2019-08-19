#!/bin/sh

# soft-off program
# This program uses OpenWRT/LEDE's sysupgrade functionality to get
# a device into a "soft-off" state. This is because not all devices
# do have a working "poweroff" and if a user wants to unplug the
# device in order to move it. she/he might want this functionality.

# Currently, this script tries to put all attached harddrives into
# standby mode (by deleting them, so the kernel will put them to
# sleep) and tries to powers off all LEDs.

. /lib/functions.sh
. /lib/functions/system.sh
. /lib/upgrade/common.sh

case "$1" in
stage2)
	for dev in /dev/sd*[a-z]; do
		rawdev=$(basename "$dev")
		echo 1 > "/sys/class/block/$rawdev/device/delete"
	done

	for leds in /sys/class/leds/*; do
		echo "none" > "$leds/trigger"
		echo 0 > "$leds/brightness"
	done

	while :; do
		sleep 10000;
	done
	;;
*)
	install_bin /sbin/upgraded
	install_bin "$0"

	ifdown -a

	ubus call system sysupgrade "{
		\"prefix\": $(json_string "$RAM_ROOT"),
		\"path\": $(json_string "badfile"),
		\"command\": $(json_string "$0 stage2")
	}"
	;;
esac
