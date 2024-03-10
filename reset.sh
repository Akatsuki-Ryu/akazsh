#!/usr/bin/env bash
echo now we will UNinstall brew and reset. press N to skip

read -rp "ok? (y/N): " yn
case "$yn" in [yY]*)
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	brew remove --force "${brew list}" --ignore-dependencies
	brew cask remove --force "${brew cask list}"

  # remove oh-my-zsh
  rm -rf ~/.oh-my-zsh

	;;
*) echo "skip." ;; esac

cd ..
echo this will overwrite the setting on this user ....

read -rp "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *)
	echo "abort."
	exit
	;;
esac

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
ln -s akazsh/mytmux/.tmux.conf.local .tmux.conf.local
ln -s akazsh/mytmux/.tmux.conf .tmux.conf
ln -s akazsh/.zshrc .zshrc
ln -s akazsh/.tigrc .tigrc
