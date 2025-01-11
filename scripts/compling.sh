#!/bin/bash
##########################################
# Part 3 Constructing a Temporary System #
##########################################
source "$(dirname $0)/srcs/color.sh"
source "$(dirname $0)/srcs/tools.sh"

# Setup environment variables
LFS=/mnt/lfs
SOURCES=$LFS/sources

install_binutils
install_gcc
install_linux_api_headers
install_glibc

exit

