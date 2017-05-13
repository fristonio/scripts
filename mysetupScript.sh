# Update Upgrade
sudo apt-get update
sudo apt-get upgrade

# LAMP install (PHP 7.0)
sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-cli php-curl
sudo apt-get install -y phpmyadmin php-mbstring php-gettext
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf &&
sudo a2enconf phpmyadmin.conf &&
sudo service apache2 reload

# INSTALL APPLICATIONS  :

# Add Repositories
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository ppa:synapse-core/ppa -y
sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily
# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo add-apt-repository ppa:wireshark-dev/stable -y
#Google-Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

#Heroku
sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -


# Update Repos.
sudo apt-get install -y terminator
sudo apt-get install -y ffmpeg
sudo apt-get install -y youtube-dl
sudo apt-get install -y vlc
sudo apt-get install -y virtual-box
sudo apt-get install -y synapse
sudo apt-get install -y spotify-client
sudo apt-get install -y wireshark
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y redis-server
sudo apt-get install -y sublime-text-installer
sudo apt-get install -y git
sudo apt-get install -y heroku
sudo apt-get install -y vim
sudo apt-get install -y curl
sudo apt-get install -y python-dev python3-dev python-pip python3-pip
sudo apt-get install -y traceroute
sudo apt-get install -y tshark
sudo apt-get install -y nmap
sudo pip install virtualenv

#ZSH and oh-my-zsh
sudo apt-get install -y zsh &&
sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Ruby and gems
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 &&
curl -sSL https://get.rvm.io | bash -s stable &&
rvm requirements &&
rvm install ruby &&
rvm use ruby --default &&
rvm rubygems current &&
gem install bundle &&
bundle install

#Composer
curl -sS https://getcomposer.org/installer | php &&
sudo mv composer.phar /usr/local/bin/composer

#NPM
sudo apt-get install -y npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
source ~/.zshrc
# enter the version you want to install
nvm install v7.10.0
nvm alias default 4.7.3
clear
echo ""
echo "===================="
echo " TIME FOR A REBOOT! "
echo "===================="
echo ""

