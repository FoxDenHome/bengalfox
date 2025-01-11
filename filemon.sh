#!/bin/bash
set -euo pipefail

exec /opt/scripts/filemon.py \
    '@/var/lib/docker/362144.362144/volumes/e621dumper_config/_data/e621.maxid' \
    '@/mnt/zhdd/furaffinity/data/submissions.max-id' \
    > /var/lib/prometheus/node-exporter/filemon.prom
