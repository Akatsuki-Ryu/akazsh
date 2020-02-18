# remove the old installations 
apt-get remove docker docker-engine docker.io

# install packages
apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# install gpg key 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key  add -

#depository 
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

 cat /etc/apt/sources.list | grep docker
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
# deb-src [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable

apt-cache madison docker-ce


 apt install docker-ce    

# ユーザをdockerグループに追加すると，sudoなしでdockerコマンドを実行できるので追加します．
 sudo usermod -aG docker $USER

# dockerを起動し，常時起動するようにします
sudo systemctl enable docker

