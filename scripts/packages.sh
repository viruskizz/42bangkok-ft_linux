#!/bin/bash
# Setup environment variables
LFS=/mnt/lfs
HOME_VAGRANT=/home/vagrant
HOME_LFS=/home/lfs

#####################
# Download Packages #
#####################
mkdir -v -p $LFS/sources
chmod -v a+wt $LFS/sources

mkdir -vp $LFS/sources/confs

cp $HOME_VAGRANT/confs/md5sums $LFS/sources/confs
cp $HOME_VAGRANT/confs/wget-list $LFS/sources/confs

# Download all packages from list

wget --input-file=$LFS/sources/confs/wget-list \
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
mkdir -v $LFS/tools/include
ln -sv $LFS/tools /

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
echo "lfs" | passwd lfs --std-in

chown -v lfs $LFS/tools
chown -v lfs $LFS/sources


# For login shell read .bash_profile
cat > $HOME_LFS/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

# For non-login shell read .bashrc
cat > $HOME_LFS/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
export MAKEFLAGS="-j $(nproc)"
EOF

source $HOME_LFS/.bash_profile

chown -v lfs:lfs $HOME_LFS/.bashrc
chown -v lfs:lfs $HOME_LFS/.bash_profile
