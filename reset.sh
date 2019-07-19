#!/usr/bin/env bash
echo now we will UNinstall brew and reset. press N to skip

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

;; *) echo "skip." ; ;; esac


cd ..
echo this will overwrite the setting on this user ....

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

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


