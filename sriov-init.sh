#!/bin/sh
set -e

echo 0 > /sys/class/net/ens1f0np0/device/sriov_drivers_autoprobe
echo 1 > /sys/class/net/ens1f0np0/device/sriov_numvfs

ip link set ens1f0np0 vf 0 mac 8e:fe:0c:57:90:ae
