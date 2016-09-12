#!/bin/bash -eux
set -eux

# Add appknox user to sudoers.
echo "appknox        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

apt -y update
apt -y install software-properties-common python-setuptools python-dev python-pip

apt-add-repository ppa:ansible/ansible
apt -y update
apt -y install ansible
