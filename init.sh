#!/usr/bin/env bash
echo now we will install brew . press N to skip

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install rcmdnk/file/brew-file
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
;; *) echo "skip." ; ;; esac








cd ..
echo this will overwrite the setting on this user ....

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# linking diff_highlight to system . git should be from brew . this needs to be confirmed
	sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight


#installing oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

#install font for powerlevel
sudo apt-get install fonts-powerline

#install autojump 
sudo apt-get install autojump

# taking gitconfig to seperate machines.
rm -r .gitconfig
rm -r .config
rm -r .tmux.conf
rm -r .tmux.conf.local
rm -r .zshrc
rm -r .tigrc

#ln -s akazsh/.gitconfig .gitconfig
cp akazsh/.gitconfig .gitconfig
 ln -s akazsh/.config .config
  ln -s akazsh/tmux/.tmux.conf.local .tmux.conf.local
  ln -s akazsh/tmux/.tmux.conf .tmux.conf
  ln -s akazsh/.zshrc .zshrc
  ln -s akazsh/.tigrc .tigrc


