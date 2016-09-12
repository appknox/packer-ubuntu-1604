#!/bin/bash -eux
set -eux

# uninstall ansible and remove ppa
apt -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible

# uninstall ansible and other pip deps
pip freeze | grep -v "^-e" | xargs pip uninstall -y
apt -y purge --auto-remove python-setuptools python-dev python-pip

# apt cleanup
apt autoremove -y
apt clean -y
apt update

# delete scripts if any
rm -f /home/appknox/*.sh

# clear dhcp leases
dhclient -r

# zero out the free space
dd if=/dev/zero of=/EMPTY bs=1M || /bin/true
rm -f /EMPTY

# ensure packer doesn't quit too early
sync
