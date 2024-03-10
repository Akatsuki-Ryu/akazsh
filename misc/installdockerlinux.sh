#!/usr/bin/env bash
# remove the old installations
sudo apt-get remove docker docker-engine docker.io containerd runc

# install packages
apt install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

# install gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#depository
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

cat /etc/apt/sources.list | grep docker
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
# deb-src [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable

apt-cache madison docker-ce

apt install docker-ce docker-ce-cli containerd.io

# ユーザをdockerグループに追加すると，sudoなしでdockerコマンドを実行できるので追加します．
sudo usermod -aG docker $USER

# dockerを起動し，常時起動するようにします
sudo systemctl enable docker

#install the docker composer
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#docker compose permission
sudo chmod +x /usr/local/bin/docker-compose

#permissions for deamon
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo rm -r ~/.docker/
