#!/bin/sh

# soft-reboot program
# This program uses OpenWRT/LEDE's sysupgrade functionality to reboot
# the device more gracefully.

[ -x /bin/ubus ] || /bin/busybox reboot $@

. /lib/functions.sh
. /lib/functions/system.sh
. /lib/upgrade/common.sh

case "$1" in
stage2)
	for leds in /sys/class/leds/*; do
		echo 0 > $leds/brightness
	done
	sync

	umount /overlay || mount /overlay -o remount,ro
	umount /rom

	sync

	[ -f /proc/sysrq-trigger ] && echo u > /proc/sysrq-trigger

	/bin/busybox reboot $@

	while :; do
		sleep 10000;
	done
	;;
*)
	install_bin /sbin/upgraded
	install_bin $0

	ifdown -a

	/bin/ubus call system sysupgrade "{
		\"prefix\": $(json_string "$RAM_ROOT"),
		\"path\": $(json_string "badfile"),
		\"command\": $(json_string "$0 stage2 $1 $2 $3")
	}" || /bin/busybox reboot
	;;
esac
