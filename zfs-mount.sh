#!/bin/sh
zpool import -d /dev/disk/by-id -a

zdone() {
    mount --bind /mnt/zssd/nas/torrent /mnt/zhdd/nas/torrent
    mount --bind /mnt/zssd/nas/usenet /mnt/zhdd/nas/usenet
    mount --bind /mnt/zssd/nas/tmp /mnt/zhdd/nas/tmp
    exit 0
}

zfs mount -a -l && zdone
sleep 5
zfs mount -a -l && zdone
sleep 5
zfs mount -a -l && zdone
