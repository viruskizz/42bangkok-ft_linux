# ft_linux
The first project of the Kernel branch! This is a simple LFS so that you can build your own distribution which will be used in the next projects

## Bible
The base Linux official tutorial is [Linux From Scratch (LFS) version 8.4](https://www.linuxfromscratch.org/museum/lfs-museum/8.4-systemd/LFS-BOOK-8.4-systemd-HTML)

## Vagrant on WSL
For Window user that using WSL as linux host.

1. Install Vagrant plugin
```sh
vagrant plugin install virtualbox_WSL2
```

2. Add environment in `.bashrc` in WSL
```sh
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
```
[Vagrant on WSL](https://developer.hashicorp.com/vagrant/docs/other/wsl)


## Packages to Install
The following versions are known to work together correctly. However, you are free to use the versions you want.
- [] Acl (2.2.52)
- [] Attr (2.4.47)
- [] Autoconf (2.69)
- [] Automake (1.15)
- [] Bash (4.3.30)
- [] Bc (1.06.95)
- [] Binutils (2.25.1)
- [] Bison (3.0.4)
- [] Bzip2 (1.0.6)
- [] Check (0.10.0)
- [] Coreutils (8.24)
- [] DejaGNU (1.5.3)
- [] Diffutils (3.3)
- [] Eudev (3.1.2)
- [] E2fsprogs (1.42.13)
- [] Expat (2.1.0)
- [] Expect (5.45)
- [] File (5.24)
- [] Findutils (4.4.2)
- [] Flex (2.5.39)
- [] Gawk (4.1.3)
- [] GCC (5.2.0)
- [] GDBM(1.11)
- [] Gettext (0.19.5.1)
- [] Glibc (2.22)
- [] GMP(6.0.0a)
- [] Gperf (3.0.4)
- [] Grep (2.21)
- [] Groff (1.22.3)
- [] GRUB (2.02 beta2)
- [] Gzip (1.6)
- [] Iana-Etc (2.30)
- [] Inetutils (1.9.4)
- [] Intltool (0.51.0)
- [] IPRoute2 (4.2.0)
- [] Kbd (2.0.3)
- [] Kmod (21)
- [] Less (458)
- [] Libcap (2.24)
- [] Libpipeline (1.4.1)
- [] Libtool (2.4.6)
- [] M4 (1.4.17)
- [] Make (4.1)
- [] Man-DB (2.7.2)
- [] Man-pages (4.02)
- [] MPC (1.0.3)
- [] MPFR (3.1.3)
- [] Ncurses (6.0)
- [] Patch (2.7.5)
- [] Perl (5.22.0)
- [] Pkg-config (0.28)
- [] Procps (3.3.11)
- [] Psmisc (22.21)
- [] Readline (6.3)
- [] Sed (4.2.2)
- [] Shadow (4.2.1)
- [] Sysklogd (1.5.1)
- [] Sysvinit (2.88dsf)
- [] Tar (1.28)
- [] Tcl (8.6.4)
- [] Texinfo (6.0)
- [] Time Zone Data (2015f)
- [] Udev-lfs Tarball (udev-lfs-20140408)
- [] Util-linux (2.27)
- [] Vim (7.4)
- [] XML::Parser (2.44)
- [] Xz Utils (5.2.1)
- [] Zlib (1.2.8)- [] 