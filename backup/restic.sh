#!/bin/sh

export XDG_CACHE_HOME="/mnt/tmpdrv/restic"

. /mnt/keydisk/restic-config.sh

/usr/bin/restic -r "$REPO" "$@"
