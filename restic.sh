#!/bin/sh

runx() {
    export CMD="$1"
    shift 1
    "$CMD" "$@"
}

export RESTIC_REPOSITORY='s3:s3.us-west-001.backblazeb2.com/bengalfox-backups'
runx "$@"

REST_SERVER_PASSWORD="$(cat /mnt/keydisk/rest-server-password | tr -d '\r\n\t ')"
export RESTIC_REPOSITORY="rest:https://bengalfox:$REST_SERVER_PASSWORD@restic.doridian.net/bengalfox/main"
runx "$@"
