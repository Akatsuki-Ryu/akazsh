#!/usr/bin/env bash
echo now we will install basic apps , N to skip

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) #this is the condition yes

#install basic system components
sudo apt-get install -y zsh
sudo apt-get install -y curl


#installing oh my zsh and powerlevel9k
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

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
sudo apt-get install -y ncdu
sudo apt-get install -y duf	 #better df
sudo apt-get install -y exa	#better ls

#install docker
sudo apt install docker-compose -y
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker


# linking diff_highlight to system . git should be from brew . this needs to be confirmed
	sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight




;; *)  #this is the condition no
 echo "skip." ; ;; esac






# exit

cd ..
echo this will overwrite the setting on this user ....

read -p "ok? (y/N): " yn
case "$yn" in [yY]*)  #this is condition for yes







# taking gitconfig to seperate machines.
rm -r .gitconfig
rm -r .config
rm -r .tmux.conf
rm -r .tmux.conf.local
rm -r .zshrc
rm -r .tigrc
rm -r .p10k.zsh

#ln -s akazsh/.gitconfig .gitconfig
cp akazsh/.gitconfig .gitconfig
ln -s akazsh/.config .config
ln -s akazsh/.tmux/.tmux.conf.local .tmux.conf.local
ln -s akazsh/.tmux/.tmux.conf .tmux.conf
ln -s akazsh/.zshrc .zshrc
ln -s akazsh/.tigrc .tigrc
ln -s akazsh/.p10k.zsh .p10k.zsh



	;; *) #this is condition for no

echo "abort." ; exit ;; esac
