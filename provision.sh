#!/bin/bash

# Skip ssh new host check.
cat<<EOF | sudo tee ~/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  User ubuntu
EOF

sudo apt-get update
sudo apt-get install -y git git-core

sudo adduser -home /home/git --disabled-password git

cd /home/git/.ssh
sudo mkdir /home/git/.ssh
sudo cp /home/ubuntu/.ssh/authorized_keys /home/git/.ssh/
sudo chown -R git:git /home/git/.ssh
sudo chmod 700 !$
sudo chmod 600 /home/git/.ssh/*
