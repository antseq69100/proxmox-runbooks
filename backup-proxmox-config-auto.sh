#!/bin/bash

BACKUP_DIR="/mnt/elements/proxmox/host-config"
DATE=$(date +%F)

if mountpoint -q /mnt/elements; then

    mkdir -p "$BACKUP_DIR"

    tar czf "$BACKUP_DIR/proxmox-config-$DATE.tar.gz" \
    /etc/pve \
    /etc/network/interfaces \
    /etc/hosts \
    /etc/hostname \
    /etc/apt \
    /etc/fstab

    ls -tp "$BACKUP_DIR"/proxmox-config-*.tar.gz 2>/dev/null | grep -v '/$' | tail -n +15 | xargs -r rm --

fi
