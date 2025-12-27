#!/bin/bash

set -euo pipefail

IF="/dev/mmcblk0"
OF="/mnt/tower_files/backups/labpi/labpi_$(date +%m%d%Y).img.gz"

echo "Creating compressed image of $IF at $OF"

sudo dd if=$IF bs=1M count=10 | gzip -c -9 > $OF
sync

echo "Image creation complete at $(date +"%H:%M:%S"): $OF"

echo "Checking for old images to delete..."

deleted_file=$(find /mnt/tower_files/backups/labpi/ -name "labpi_*.img.gz" -type f -mtime +28 -delete -print)

echo "Image cleanup complete at $(date +"%H:%M:%S"). Files deleted: ${deleted_file:-None}"