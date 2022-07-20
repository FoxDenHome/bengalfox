#!/bin/sh

set -ex

umount /mnt/gocryptfs/zhdd || true
umount /mnt/gocryptfs/zssd || true
mkdir -p /mnt/gocryptfs/zhdd
mkdir -p /mnt/gocryptfs/zssd
gocryptfs --reverse --passfile /mnt/keydisk/gocryptfs-icefox --exclude nas/torrent --exclude nas/usenet /mnt/zhdd /mnt/gocryptfs/zhdd
gocryptfs --reverse --passfile /mnt/keydisk/gocryptfs-icefox --exclude nas/torrent --exclude nas/usenet /mnt/zssd /mnt/gocryptfs/zssd

SYNC_COMMAND="fpsync -n 8 -f 1000  -s $((100 * 1024 * 1024)) -o '-aogXAE --numeric-ids'"
eval $SYNC_COMMAND /mnt/gocryptfs/zssd/ nas@icefox.doridian.net:/mnt/zhdd/nas/zssd/
eval $SYNC_COMMAND /mnt/gocryptfs/zhdd/ nas@icefox.doridian.net:/mnt/zhdd/nas/zhdd/

umount /mnt/gocryptfs/zhdd
umount /mnt/gocryptfs/zssd
