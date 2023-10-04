#!/bin/sh
set -e
cd /opt/tapemgr
exec  python3 . '--changer=/dev/tape/by-id/scsi-1BDT_FlexStor_II_00L2U78BK968_LL0' '--changer-drive-index=0' '--age-recipients=/mnt/keydisk/tape-age.pub' "$@"
