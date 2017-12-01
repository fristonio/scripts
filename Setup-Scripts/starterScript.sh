#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-cli php-curl
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y python-dev python3-dev python-pip python3-pip
sudo apt-get install -y docker-ce

#Composer
curl -sS https://getcomposer.org/installer | php &&
sudo mv composer.phar /usr/local/bin/composer

#Node
sudo apt-get install -y npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

source ~/.bashrc
nvm install node
nvm use node
