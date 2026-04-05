# Proxmox VE Host Configuration Backup Runbook

This runbook describes how to implement automated configuration backups for a standalone Proxmox VE host.

## Features

- Daily automated configuration backup
- Rolling retention (14 versions)
- Immutable golden baseline backup
- External storage separation
- Recovery-ready architecture

## Backup scope

The following configuration paths are included:
/etc/pve
/etc/network/interfaces
/etc/hosts
/etc/hostname
/etc/apt
/etc/fstab


These allow restoring:

- storage configuration
- VM definitions
- network configuration
- Proxmox users & ACL
- repository configuration

## Automated backup script

Location:
/usr/local/sbin/backup-proxmox-config-auto.sh

Executed daily via cron:
0 3 * * * /usr/local/sbin/backup-proxmox-config-auto.sh

Retention policy:

14 backups


## Golden baseline backup

A protected baseline configuration archive is created:


proxmox-config-golden.tar.gz


Locked using:


chattr +i


This prevents accidental deletion or modification.

## Storage location

External disk:


/mnt/elements/proxmox/host-config/


## Recovery workflow

Reinstall Proxmox VE

Restore configuration:


tar xzf proxmox-config-YYYY-MM-DD.tar.gz -C /


Reboot host

Restore VM backups if required

## Why this matters

This approach enables fast recovery after:

- system disk failure
- configuration corruption
- network misconfiguration
- storage configuration loss

Inspired by lightweight enterprise-grade hypervisor recovery practices.
