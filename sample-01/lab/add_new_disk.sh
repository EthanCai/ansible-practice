#!/bin/bash -l

# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'


if [ -f /etc/disk_added_date ]
then
   echo "disk already added so exiting."
   exit 0
fi


fdisk -u /dev/sda <<EOF || true
p
n
p
3


t
3
8e
w
EOF

partprobe   # inform the kernel of the change without reboot

pvcreate /dev/sda3
vgextend centos /dev/sda3
lvextend /dev/centos/root /dev/sda3
xfs_growfs /dev/centos/root
df -h

date > /etc/disk_added_date