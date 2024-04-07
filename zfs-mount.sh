#!/bin/sh
zpool import -d /dev/disk/by-id -a

zdone() {
    exit 0
}

zfs mount -a -l && zdone
sleep 5
zfs mount -a -l && zdone
sleep 5
zfs mount -a -l && zdone
