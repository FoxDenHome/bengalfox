#!/bin/sh

set -ex

#SYNC_COMMAND="fpsync -n 8 -f 1000  -s $((100 * 1024 * 1024)) -o '-aE --numeric-ids'"
SYNC_COMMAND="rsync --delete -avE --numeric-ids --progress"

gcsync() {
	DS="$1"
	mkdir -p "/mnt/gocryptfs/$DS"
	mount | grep -qF "/mnt/gocryptfs/$DS" || gocryptfs --reverse --passfile /mnt/keydisk/gocryptfs-icefox --exclude nas/torrent --exclude nas/usenet "/mnt/$DS" "/mnt/gocryptfs/$DS"
	eval $SYNC_COMMAND "/mnt/gocryptfs/$DS/" "nas@icefox.doridian.net:/mnt/zhdd/nas/$DS/"
}

gcsync zhdd
