#!/bin/sh

/opt/backup/restic.sh forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune

