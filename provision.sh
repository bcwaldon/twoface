#!/bin/bash

# Skip ssh new host check.
cat<<EOF | sudo tee ~/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  User ubuntu
EOF

sudo mkdir /etc/twoface
sudo cat<<EOF | sudo tee /etc/twoface/repositories
http://github.com/openstack/glance
http://github.com/openstack/nova
http://github.com/
EOF

sudo apt-get update
sudo apt-get install -y git git-core python-setuptools

sudo adduser -home /home/git --disabled-password --quiet git

git clone http://github.com/bcwaldon/twoface
cd twoface
python setup.py install

cd /home/git/.ssh
sudo mkdir /home/git/.ssh
sudo cp /home/ubuntu/.ssh/authorized_keys /home/git/.ssh/
sudo chown -R git:git /home/git/.ssh
sudo chmod 700 !$
sudo chmod 600 /home/git/.ssh/*

sudo su git -
twoface-init
