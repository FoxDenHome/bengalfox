#!/bin/sh
set -e
cd /opt/tapemgr
exec  python3 . '--changer=/dev/sch0' '--mount=/mnt/tape2' '--changer-drive-index=1' '--age-recipients=/mnt/keydisk/tape-age.pub' "$@"
