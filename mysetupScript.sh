#Update Upgrade
sudo apt-get update
sudo apt-get upgrade

#LAMP install (PHP 7.0)
sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-cli php-curl
sudo apt-get install -y phpmyadmin php-mbstring php-gettext
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf && sudo a2enconf phpmyadmin.conf && sudo service apache2 reload

#INSTALL APPLICATIONS
    # chrome slack spotify mplayer terminator phpmyadmin ffmpeg youtube-dl tig wireshark virtualBox
sudo apt-get install -y terminator
sudo apt-get install -y ffmpeg
sudo apt-get install -y youtube-dl
sudo apt-get install -y vlc
sudo apt-get install -y virtual-box

#Synapse application launcher
sudo add-apt-repository ppa:synapse-core/ppa && sudo apt-get update && sudo apt-get install synapse

#Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 && echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list && sudo apt-get update && sudo apt-get install spotify-client

#Wireshark
sudo add-apt-repository ppa:wireshark-dev/stable && sudo apt-get update && sudo apt-get install wireshark

#Google-Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && sudo apt-get update && sudo apt-get install google-chrome-stable



#install tools
    # tshark traceroute zsh oh-my-zsh nmap pip redis-server npm virtualenv nvm heroku git gem arp-scan vim rdare2
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y curl
sudo apt-get install -y python-dev python3-dev python-pip python3-pip
sudo pip install virtualenv
sudo apt-get install -y traceroute
sudo apt-get install -y tshark
sudo apt-get install -y nmap
sudo apt-get install -y zsh && sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && curl -sSL https://get.rvm.io | bash -s stable && rvm requirements && rvm install ruby && rvm use ruby --default && rvm rubygems current && gem install bundle && bundle install

