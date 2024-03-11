#!/usr/bin/env bash
echo now we will install brew . press N to skip

read -rp "ok? (y/N): " yn
case "$yn" in [yY]*)
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	export PATH="/opt/homebrew/sbin:$PATH"

	brew install rcmdnk/file/brew-file
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# brew install sambadevi/powerlevel9k/powerlevel9k
	brew install powerlevel10k

	#clean up the powerlevel10k folder if exists
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

	#clean up zsh plugins if folder exists
	rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	rm -rf "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/zsh-completions

	#installing zsh plugins
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	# git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-~/.oh-my-zsh}"/custom/plugins/zsh-completions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/zsh-completions

	read -rp "install brew apps and cask apps ,ok? (y/N): " yn
	case "$yn" in [yY]*)
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		./misc/brewinit.sh
		./misc/caskinit.sh
		;;
	*) echo "skip." ;; esac
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

# install rosetta2 for apple silicon macs
softwareupdate --install-rosetta --agree-to-license

# linking diff_highlight to system . git should be from brew . this needs to be confirmed
sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

# taking gitconfig to seperate machines.
rm -r .gitconfig
rm -r .config
rm -r .tmux.conf
rm -r .tmux.conf.local
rm -r .zshrc
rm -r .p10k.zsh

#ln -s akazsh/.gitconfig .gitconfig
cp akazsh/.gitconfig .gitconfig
ln -s akazsh/.config .config
ln -s akazsh/mytmux/.tmux.conf.local .tmux.conf.local
ln -s akazsh/mytmux/.tmux.conf .tmux.conf
ln -s akazsh/.zshrc .zshrc
ln -s akazsh/.p10k.zsh .p10k.zsh
