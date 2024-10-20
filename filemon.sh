#!/bin/bash
set -euo pipefail

exec /opt/scripts/filemon.py \
    '@/var/lib/docker/362144.362144/volumes/e621dumper_config/_data/e621.maxid' \
    '@/mnt/zhdd/furaffinity/data/submissions.max-id' \
    '/mnt/zhdd/dav/backups-fennec/kopia.maintenance.f' \
    '/mnt/zhdd/dav/backups-capefox/kopia.maintenance.f' \
    > /var/lib/prometheus/node-exporter/filemon.prom
