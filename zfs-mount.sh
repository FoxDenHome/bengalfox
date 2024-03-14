#!/bin/sh
zpool import -d /dev/disk/by-id -a

zfs mount -a -l && exit 0
sleep 5
zfs mount -a -l && exit 0
sleep 5
zfs mount -a -l && exit 0

mount --bind /mnt/zssd/nas/torrent /mnt/zhdd/nas/torrent
mount --bind /mnt/zssd/nas/usenet /mnt/zhdd/nas/usenet
mount --bind /mnt/zssd/nas/tmp /mnt/zhdd/nas/tmp
