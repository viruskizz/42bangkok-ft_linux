#!/bin/bash
LFS=$LFS_PATH

#####################
# Download Packages #
#####################
mkdir -v -p $LFS/sources
chmod -v a+wt $LFS/sources

mkdir -vp $LFS/sources/confs

cp $HOME/confs/md5sum $LFS/sources/confs
cp $HOME/confs/wget-list $LFS/sources/confs

# Download all packages from list
cd $LFS/sources
wget --input-file=confs/wget-list \
    --no-clobber \
    --continue \
    --directory-prefix=$LFS/sources
# Check md5sum
pushd $LFS/sources
  md5sum -c confs/md5sums
popd

chown root:root $LFS/sources/*

####################$
# Setup Environment #
#####################
mkdir -v $LFS/tools

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
echo lfs | passwd lfs --stdin

chown -v lfs $LFS/tools
chown -v lfs $LFS/sources

su -l lfs

# For login shell read .bash_profile
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

# For non-login shell read .bashrc
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
export MAKEFLAGS='-j $(nproc)'
EOF

source ~/.bash_profile
