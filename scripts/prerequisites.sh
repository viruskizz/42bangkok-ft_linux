#/bin/bash
source $(dirname $0)/color.sh

# Create a partition
# https://www.youtube.com/watch?v=nttLR55lFAY&ab_channel=BlueMonkey4n6
LFS_DEVICE=/dev/sdb

PARTED_EXISTING=$(parted --script $LFS_DEVICE print | awk '{print $1}' | grep '4')

if [ ! "$PARTED_EXISTING" ]; then
    echo $Cyan"CREATING LFS Partition"$Color_Off
    parted --script $LFS_DEVICE \
        --align optimal \
        unit MiB \
        mklabel gpt \
        mkpart "bios" fat32 1MiB 250MiB \
        mkpart "boot" ext2 250MiB 750MiB \
        mkpart "swap" ext2 750MiB 2GiB \
        mkpart "root" ext4 2GiB 100% \
        set 1 boot on \
        set 3 swap on
    echo $Cyan"Making LFS Filesystem"$Color_Off
    mkfs.vfat -F32 "${LFS_DEVICE}1"
    mkswap "${LFS_DEVICE}3"
    mkfs -v -t -F -L boot  ext2 "${LFS_DEVICE}2"
    mkfs -v -t -F -L root ext4 "${LFS_DEVICE}4"
fi
echo $Green"LFS Partition & Filesystem has been created"$Color_Off
fdisk -l $LFS_DEVICE
