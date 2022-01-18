#!/bin/sh
#zpool import -d /dev/disk/by-id -a
zfs mount -a -l && exit 0
sleep 5
zfs mount -a -l && exit 0
sleep 5
zfs mount -a -l && exit 0
