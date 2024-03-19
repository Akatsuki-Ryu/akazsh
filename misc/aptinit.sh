#install font for powerlevel
sudo apt-get install -y fonts-powerline

#install some basic features
sudo apt-get install -y autojump
sudo apt-get install -y tig
# sudo apt-get install -y terminator
sudo apt-get install -y mc
sudo apt-get install -y ncdu
sudo apt-get install -y micro
sudo apt-get install -y fzf
sudo apt-get install -y fd-find
sudo apt-get install -y ripgrep
sudo apt-get install -y gh

#install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

sudo apt-get install -y prettyping
#sudo apt-get install -y bat
sudo apt-get install -y duf #better df
#sudo apt-get install -y exa	#better ls , this is deprecated
./misc/installezalinux.sh
sudo apt-get install -y htop
sudo apt-get install -y btop

#install sshd
sudo apt-get install -y openssh-server

#install docker
./misc/installdockerlinux.sh
# allow normal user to use docker, without sudo
sudo groupadd docker
sudo gpasswd -a "$USER" docker
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

# install python
sudo apt-get install -y python3
sudo apt-get install -y python3-pip
