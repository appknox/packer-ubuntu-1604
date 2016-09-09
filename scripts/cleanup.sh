#!/bin/bash -eux
set -eux

# uninstall Ansible and remove PPA
apt -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible

# uninstall Ansible and other pip deps
pip freeze | grep -v "^-e" | xargs pip uninstall -y
easy_install -m pip
apt -y purge --auto-remove python-setuptools python-dev

# apt cleanup
apt autoremove
apt clean
apt update

# delete unneeded files
rm -f /home/appknox/*.sh

# zero out the free space
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# ensure Packer doesn't quit too early
sync
