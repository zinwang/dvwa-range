#!/usr/bin/bash

## Update
sudo apt update

## Install docker
sudo apt install -y docker.io
sudo systemctl enable docker --now

sudo usermod -aG docker $USER

## Install docker-compose
wget http://ftp.tw.debian.org/debian/pool/main/d/docker-compose/docker-compose_2.26.1-4_amd64.deb -O /tmp/docker-compose_2.26.1-4_amd64.deb
sudo apt-get install /tmp/docker-compose_2.26.1-4_amd64.deb

## Install DVWA
wget https://github.com/digininja/DVWA/archive/refs/heads/master.zip -O dvwa/master.zip
unzip dvwa/master.zip -d dvwa
mv dvwa/DVWA-master dvwa/dvwa
rm dvwa/master.zip
