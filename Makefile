all: up

up:
	vagrant up

down:
	vagrant halt

ssh:
	vagrant ssh

clean:
	vagrant destroy --force

fclean: clean
	rm -rf .vagrant
	rm -rf '/mnt/c/Users/kizza/VirtualBox VMs/ft_linux'
	rm -rf '/mnt/c/Users/intel/VirtualBox VMs/ft_linux'

.PHONY: up down clean fclean