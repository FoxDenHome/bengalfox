#!/bin/sh
set -e
cd /opt/tapemgr
exec  python3 . '--changer=/dev/sch0' '--changer-drive-index=0' '--age-recipients=/mnt/keydisk/tape-age.pub' "$@"
