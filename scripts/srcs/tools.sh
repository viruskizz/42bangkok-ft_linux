#!/bin/bash
##########################
# All Tools Installation #
##########################

##################################
# Installation of Cross Binutils #
##################################
install_binutils () {
    cd $SOURCES
    tar -xpvf binutils-2.32.tar.xz
    cd binutils-2.32
    mkdir -vp build
    cd build

    ../configure --prefix=/tools            \
                --with-sysroot=$LFS        \
                --with-lib-path=/tools/lib \
                --target=$LFS_TGT          \
                --disable-nls              \
                --disable-werror

    make

    case $(uname -m) in
    x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
    esac

    make install

    cd $SOURCES
    rm -f binutils-2.32.tar.xz
    rm -rf binutils-2.32
}
