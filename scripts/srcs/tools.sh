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
  rm -rf binutils-2.32.tar.xz
  rm -rf binutils-2.32
}


#############################
# Installation of Cross GCC #
#############################
install_gcc () {
  cd $SOURCES
  tar -xf gcc-8.2.0.tar.xz
  cd gcc-8.2.0

  tar -xf ../mpfr-4.0.2.tar.xz 
  mv  -v  mpfr-4.0.2/ mpfr
  tar -xf ../gmp-6.1.2.tar.xz 
  mv  -v  gmp-6.1.2 gmp
  tar -xf ../mpc-1.1.0.tar.gz 
  mv  -v  mpc-1.1.0/ mpc

  for file in gcc/config/{linux,i386/linux{,64}}.h
  do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
  done

  case $(uname -m) in
  x86_64)
      sed -e '/m64=/s/lib64/lib/' \
          -i.orig gcc/config/i386/t-linux64
  ;;
  esac

  mkdir -v build
  cd build

  ../configure                                     \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libmpx                               \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++
  make
  make install

  cd $SOURCES
  rm -rf gcc-8.2.0
  rm -f  gcc-8.2.0.tar.xz
}

#############################
# Linux 4.20.12 API Headers #
#############################
install_linux_api_headers () {
  tar -xvf linux-4.20.12.tar.xz
  cd linux-4.20.12

  make mrproper
  make INSTALL_HDR_PATH=dest headers_install
  cp -rv dest/include/* /tools/include

  cd $SOURCES
  rm -rf linux-4.20.12
  rm -f  linux-4.20.12.tar.xz
}

#########################
# Installation of Glibc #
#########################
install_glibc () {
  tar -xvf glibc-2.29.tar.xz 
  cd glibc-2.29

  mkdir -v build
  cd       build
  ../configure                         \
    --prefix=/tools                    \
    --host=$LFS_TGT                    \
    --build=$(../scripts/config.guess) \
    --disable-werror                   \
    --with-headers=/tools/include
  make
  make install

  cd $SOURCES
  rm -rf glibc-2.29
  rm -f  glibc-2.29.tar.xz
}