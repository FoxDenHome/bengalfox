#!/bin/sh

runprune() {
    export REPO="$1"
    /opt/backup/prune.sh
}

runprune 'b2:bengalfox-backups:/'
runprune 'sftp:nas@icefox.doridian.net:/mnt/zhdd/nas/restic'
