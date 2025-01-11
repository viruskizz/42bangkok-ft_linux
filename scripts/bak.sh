#/bin/bash
source srcs/color.sh

# Setup environment variables
LFS_DEVICE=/dev/sdb
LFS=/mnt/lfs

ln -sf /bin/bash /bin/sh

#Install packages for Host
apt-get update -y
apt-get install -y \
    dosfstools \
    bison \
    g++ \
    gcc \
    libisl-dev \
    gawk \
    m4 \
    make \
    patch \
    perl \
    python3 \
    texinfo\
    parted \
    wget \
    vim

# Create a partition
PARTED_EXISTING=$(parted --script $LFS_DEVICE print | awk '{print $1}' | grep '4')
if [ ! "$PARTED_EXISTING" ]; then
    echo -e $Cyan"CREATING LFS Partition"$Color_Off
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
    echo -e $Cyan"Making LFS Filesystem"$Color_Off
    mkfs.vfat -F32 "${LFS_DEVICE}1"
    mkswap -L swap "${LFS_DEVICE}3"
    mkfs.ext2 -v -L boot "${LFS_DEVICE}2"
    mkfs.ext4 -v -L root "${LFS_DEVICE}4"
fi
echo -e $Green"LFS Partition & Filesystem has been created"$Color_Off

MOUNTED_EXISTING=$(df -h $LFS)
if [ ! "$MOUNTED_EXISTING" ]; then
    echo -e $Cyan"Mounting LFS device to $LFS"$Color_Off
    mkdir -pv $LFS
    mount -v -t ext4 ${LFS_DEVICE}4 $LFS
    df -h
    swapon -v ${LFS_DEVICE}3
fi
echo -e $Green"LFS Partition has been mounted to $LFS"$Color_Off
