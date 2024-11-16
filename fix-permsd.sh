#!/bin/bash
inotifywait -P -e attrib,create --format '%w%f%0' --no-newline -r /mnt/zhdd/nas -m | xargs -0 chown -h share:share
