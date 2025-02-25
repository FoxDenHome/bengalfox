#!/bin/sh

/opt/bengalfox/restic.sh /opt/backup/run.sh /mnt/keydisk /mnt/zhdd/docker /var/lib/docker/*/volumes /efi /efi2 /mnt/zhdd/nashome /

backup_syncoid() {
    syncoid --no-privilege-elevation "$1/ROOT/$2" "bengalfox@icefox-ext.doridian.net:ztank/ROOT/$1/$2"
}

syncoid_zhdd() {
    backup_syncoid zhdd "$1"
}

syncoid_zssd() {
    backup_syncoid zssd "$1"
}

syncoid_zhdd docker
syncoid_zhdd docker/restic
syncoid_zhdd e621
#syncoid_zhdd furaffinity
syncoid_zhdd kiwix
syncoid_zhdd nas
syncoid_zhdd nashome

syncoid_zssd docker
syncoid_zssd nas
