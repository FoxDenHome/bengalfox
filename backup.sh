#!/bin/sh

runbackup() {
    export REPO="$1"
    /opt/backup/run.sh /mnt/zssd/docker /var/lib/docker/volumes /boot/efi /mnt/zhdd/nashome /
}

runbackup 'b2:bengalfox-backups:/'

REST_SERVER_PASSWORD="$(cat /mnt/keydisk/rest-server-password | tr -d '\r\n\t ')"
runbackup "rest:https://nas:$REST_SERVER_PASSWORD@icefox.doridian.net:nas/main"
