#!/bin/bash

PROJECT_ROOT=/vagrant
VM_PATH=$PROJECT_ROOT/vm
HOME_PATH=/home/vagrant
USER=vagrant

# update machine
echo "UPDATE MACHINE"
sudo apt-get update
sudo apt-get -y upgrade

# setup home directory
echo "SETUP HOME DIRECTORY"
cp $VM_PATH/$HOME_PATH/.bashrc $HOME_PATH/
chown $USER:$USER $HOME_PATH/.bashrc
cp $VM_PATH/$HOME_PATH/.profile $HOME_PATH/
chown $USER:$USER $HOME_PATH/.profile

# upgrade git
echo "UPGRADE GIT"
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install git

# install docker
echo "INSTALL DOCKER"
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# install nginx
echo "INSTALL NGINX"
sudo apt-get -y install nginx

sudo cp -r $VM_PATH/etc/* /etc
if [ -f /etc/nginx/sites-enabled/default ]
then
  sudo rm /etc/nginx/sites-enabled/default
fi

if [ ! -f /etc/nginx/sites-enabled/shopfriend-ssl.de ]
then
  sudo ln -s /etc/nginx/sites-available/shopfriend-ssl.de /etc/nginx/sites-enabled/
fi

sudo systemctl reload nginx
