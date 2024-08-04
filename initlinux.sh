#!/usr/bin/env bash
echo now we will install basic apps , N to skip

read -rp "ok? (y/N): " yn
case "$yn" in [yY]*) #this is the condition yes

  sudo apt-get update
  sudo apt-get upgrade -y
  #install basic system components
  sudo apt-get install -y zsh
  sudo apt-get install -y curl

  #installing oh my zsh and powerlevel10k
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # clean powerlevel10k folder if exists
  rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  #clean zsh plugins if folder exists
  rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  rm -rf ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

  #installing zsh plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

  # linking diff_highlight to system . git should be from brew . this needs to be confirmed
  sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

  #ask user if they want to instal the additional apps
  read -rp "install additional apps? (y/N): " yn
  case "$yn" in [yY]*) #this is the condition yes
    #installing additional apps
    ./misc/aptinit.sh
    ./misc/fontinit.sh
    ./misc/rdp/remotedesktopsetup.sh

    #ask user if they want to install snap apps
    read -rp "install snap apps? (y/N): " yn
    case "$yn" in [yY]*) #this is the condition yes
      #installing snap apps
      ./misc/snapinit.sh
      ;;
    *) #this is the condition no
      echo "skip the snap packages" ;;
    esac

    ;;
  *) #this is the condition no
    echo "skip the packages" ;;
  esac

  ;;
*) #this is the condition no
  echo "skip the basic apps" ;;
esac

# exit

cd ..
echo this will overwrite the setting on this user ....

read -rp "ok? (y/N): " yn
case "$yn" in [yY]*) #this is condition for yes

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

  ;;
*) #this is condition for no

  echo "abort."
  exit
  ;;
esac
