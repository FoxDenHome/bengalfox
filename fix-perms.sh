#!/bin/sh
set -e

fixperms() {
	find ! -group share -print -exec chgrp share {} \;
	find ! -perm 0664 -type f -print -exec chmod 664 {} \;
	find ! -perm 2775 -type d -print -exec chmod 2775 {} \;
}

cd /mnt/zhdd/nas
fixperms
