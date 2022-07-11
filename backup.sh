#!/bin/sh

runbackup() {
    export REPO="$1"
    /opt/backup/run.sh /mnt/zssd/docker /var/lib/docker/volumes /boot/efi /mnt/zhdd/nashome /
}

runbackup 'b2:bengalfox-backups:/'
runbackup 'sftp:nas@icefox.doridian.net:/mnt/zhdd/nas/restic'
