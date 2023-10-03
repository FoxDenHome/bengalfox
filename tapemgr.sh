#!/bin/sh
set -e
cd /opt/tapemgr
exec  python3 . '--device=/dev/tape/by-path/pci-0000:06:00.0-sas-phy3-lun-0-nst' '--changer=/dev/tape/by-path/pci-0000:06:00.0-sas-phy3-lun-1-changer' '--changer-drive-index=0' '--age-recipients=/mnt/keydisk/tape-age.pub' "$@"
