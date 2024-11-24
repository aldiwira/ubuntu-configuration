#!/bin/bash
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
if [ "$USER" != "root" ]
then
	echo "Please run this as root or with sudo."
	exit 2
fi
echo "Unmount disk.."
umount /dev/nvme0n1p5
echo "Fixing NTFS...."
ntfsfix /dev/nvme0n1p5
echo "Mount disk......"
mount /dev/nvme0n1p5

echo "Success for fixing mounting disk."



