#!/bin/bash

BACKUP_FILE="/mnt/elements/proxmox/host-config/proxmox-config-golden.tar.gz"

if mountpoint -q /mnt/elements; then

    if [ -f "$BACKUP_FILE" ]; then
        echo "Golden backup already exists. Aborting."
        exit 1
    fi

    sudo tar czf "$BACKUP_FILE" \
    /etc/pve \
    /etc/network/interfaces \
    /etc/hosts \
    /etc/hostname \
    /etc/apt \
    /etc/fstab

    sudo chattr +i "$BACKUP_FILE"

    echo "Golden backup created and locked."

else
    echo "Backup disk not mounted."
fi
