#/bin/bash
#Install packages for Host
sudo -s
pacman -S --noconfirm \
    bison \
    gcc \
    m4 \
    make \
    patch \
    perl \
    python3 \
    texinfo\
    parted

# create a partition
# https://www.youtube.com/watch?v=nttLR55lFAY&ab_channel=BlueMonkey4n6
fdisk -l
parted -s /dev/sdb -- \
    mklabel gpt \
    mkpart "efi" fat32 1MiB 250M \
    mkpart "boot" ext4 250M 750M \
    mkpart "swap" ext4 750M 1750M \
    mkpart "root" ext4 1750M 100%

mkfs -v -t ext4 /dev/sdb