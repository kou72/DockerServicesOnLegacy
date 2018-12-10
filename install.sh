#!/bin/bash
# Copyright (c) 2018 okawa
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


set -e

# first install

sudo apt-get update
sudo apt-get install -y vim unzip

# Copy vimrc

cp ./dotfiles/.vimrc ~/.vimrc
rm -rf ./dotfiles

# Docker install

sudo apt-get update

sudo apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

sudo apt-get update

sudo apt-get install -y docker-ce

apt-cache madison docker-ce

# No sudo & Auto docker start

# sudo groupadd docker

sudo systemctl enable docker

# Docker-compose install

sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER

