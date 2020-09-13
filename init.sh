#!/usr/bin/env bash
echo now we will install brew . press N to skip

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	brew install rcmdnk/file/brew-file
	brew install sambadevi/powerlevel9k/powerlevel9k
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	read -p "install brew apps and cask apps ,ok? (y/N): " yn
	case "$yn" in [yY]*) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	 ./misc/brewinit.sh
	 ./misc/caskinit.sh
;; *) echo "skip." ; ;; esac
;; *) echo "skip." ; ;; esac








cd ..
echo this will overwrite the setting on this user ....

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# linking diff_highlight to system . git should be from brew . this needs to be confirmed
sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

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
ln -s akazsh/.tmux/.tmux.conf.local .tmux.conf.local
ln -s akazsh/.tmux/.tmux.conf .tmux.conf
ln -s akazsh/.zshrc .zshrc
ln -s akazsh/.tigrc .tigrc


