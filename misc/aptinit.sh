#install font for powerlevel
sudo apt-get install -y fonts-powerline

#install some basic features
sudo apt-get install -y autojump
sudo apt-get install -y tig
# sudo apt-get install -y terminator
sudo apt-get install -y mc
sudo apt-get install -y ncdu
sudo apt-get install -y micro
sudo apt-get install -y prettyping
#sudo apt-get install -y bat
sudo apt-get install -y duf #better df
#sudo apt-get install -y exa	#better ls , this is deprecated
./installezalinux.sh
sudo apt-get install htop
sudo apt-get install ripgrep

#install docker
sudo apt install docker-compose -y
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker

#install tmux
sudo apt-get install -y tmux

#install dry ( docker manager in terminal)
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry

#install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

#install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

#network related
sudo apt-get install -y samba
sudo apt-get install -y netatalk
sudo cp misc/afplinux.conf /etc/netatalk/afp.conf
