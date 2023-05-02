#!/bin/sh

runx() {
    export REPO="$1"
    export CMD="$2"
    shift 2
    "$CMD" "$@"
}

runx 'b2:bengalfox-backups:/' "$@"
REST_SERVER_PASSWORD="$(cat /mnt/keydisk/rest-server-password | tr -d '\r\n\t ')"
runx "rest:https://bengalfox:$REST_SERVER_PASSWORD@icefox.doridian.net:8000/bengalfox/main" "$@"
