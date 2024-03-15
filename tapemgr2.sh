#!/bin/sh
set -e
cd /opt/tapemgr
exec  python3 . '--changer=/dev/tape/by-id/scsi-1BDT_FlexStor_II_00L2U78BK968_LL0' '--mount=/mnt/tape2' '--changer-drive-index=1' '--age-recipients=/mnt/keydisk/tape-age.pub' "$@"
