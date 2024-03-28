#!/usr/bin/env bash

echo "Are you sure you want to uninstall Homebrew and some configuration files? (y/N)"
read -r yn
[ -z "$yn" ] || {
	if [[ "$yn" == [yY] ]]; then
		case $(uname) in
		Darwin)
			echo "Uninstalling Homebrew on Mac..."
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
			brew list | xargs brew remove --force --ignore-dependencies
			brew cask list | xargs brew cask remove --force
			;;
		Linux)
			echo "Uninstalling ohmyzsh on Linux..."
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/uninstall.sh)"
			;;
		*)
			echo "Unsupported operating system."
			exit 1
			;;
		esac
	fi
}

echo "Are you sure you want to overwrite the configuration files? (y/N)"
read -r yn
[ -z "$yn" ] || {
	if [[ "$yn" == [yY] ]]; then
		rm -r .gitconfig .config .tmux.conf .tmux.conf.local .zshrc .tigrc
		cp akazsh/.gitconfig .gitconfig
		ln -s akazsh/mytmux/.tmux.conf.local .tmux.conf.local
		ln -s akazsh/mytmux/.tmux.conf .tmux.conf
		ln -s akazsh/.zshrc .zshrc
		ln -s akazsh/.tigrc .tigrc
	fi
}
