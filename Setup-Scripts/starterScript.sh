#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-cli php-curl
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y python-dev python3-dev python-pip python3-pip

#Composer
curl -sS https://getcomposer.org/installer | php &&
sudo mv composer.phar /usr/local/bin/composer

#Node
sudo apt-get install -y npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
source ~/.bashrc
nvm install v7.10.0
nvm alias default 7.10.0
