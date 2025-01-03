# ft_linux
The first project of the Kernel branch! This is a simple LFS so that you can build your own distribution which will be used in the next projects

## Bible
The base Linux official tutorial is [Linux From Scratch (LFS)](https://www.linuxfromscratch.org/~thomas/multilib/index.html)

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
