#!/bin/sh

/opt/bengalfox/restic.sh /opt/backup/run.sh /mnt/zhdd/docker /var/lib/docker/*/volumes /boot/efi /mnt/zhdd/nashome /

exit 0

backup_syncoid_root() {
    syncoid --no-privilege-elevation "$1/ROOT" "bengalfox@icefox.doridian.net:ztank/ROOT/$1"
}

backup_syncoid() {
    syncoid --no-privilege-elevation "$1/ROOT/$2" "bengalfox@icefox.doridian.net:ztank/ROOT/$1/$2"
}

syncoid_zhdd() {
    backup_syncoid zhdd "$1"
}

syncoid_zssd() {
    backup_syncoid zssd "$1"
}

backup_syncoid_root zhdd
syncoid_zhdd dav
syncoid_zhdd docker
syncoid_zhdd e621
syncoid_zhdd kiwix
syncoid_zhdd nas
syncoid_zhdd nashome

backup_syncoid_root zssd
syncoid_zssd docker
