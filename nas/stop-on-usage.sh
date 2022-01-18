#!/bin/bash

#Pid User(ID) DenyMode Access R/W Oplock SharePath Name Time
#--------------------------------------------------------------------------------------------------
#25 1002 DENY_NONE 0x20081 RDONLY NONE /mnt/nas shows/Stargate SG-1/Season 6/Stargate.SG-1.S06E01.1080p.BluRay.x264-BORDURE.mkv Mon Oct 4 14:54:46 2021

set -e

NAS_IN_USE=0

USE_ACCESS_FLAG=0x20000 # READ_CONTROL
USE_ACCESS_FLAG_INT=$(( $USE_ACCESS_FLAG ))
for l in $((docker exec samba smbstatus -L) | sed 's~  *~ ~g' | tail -n+4 | cut -d' ' -f4)
do
	if [ $(( $l & $USE_ACCESS_FLAG )) -eq $USE_ACCESS_FLAG_INT ]
	then
		NAS_IN_USE=1
	fi
done

PAUSER_TEXT="go"
if [ $NAS_IN_USE -ne 0 ]
then
	PAUSER_TEXT="PAUSED"
fi

echo "$PAUSER_TEXT" > /var/lib/docker/362144.362144/volumes/e621dumper_config/_data/pauser
