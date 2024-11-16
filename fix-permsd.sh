#!/bin/bash
inotifywait -P -e attrib,create --format '%w%f%0' --no-newline -r /mnt/zhdd/nas -m | \
    while IFS= read -r -d '' file
    do
        chown -h share:share "$file"
        if [ -d "$file" ]; then
            chmod -h 2775 "$file"
        else
            chmod -h 664 "$file"
        fi
    done
