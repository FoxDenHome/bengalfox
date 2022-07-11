#!/bin/sh

runx() {
    export REPO="$1"
    /opt/backup/run.sh /mnt/zssd/docker /var/lib/docker/volumes /boot/efi /mnt/zhdd/nashome /
}

runx 'b2:bengalfox-backups:/'
REST_SERVER_PASSWORD="$(cat /mnt/keydisk/rest-server-password | tr -d '\r\n\t ')"
runx "rest:https://nas:$REST_SERVER_PASSWORD@icefox.doridian.net:8000/nas/main"