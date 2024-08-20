#!/usr/bin/env bash

#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 <parameter>"
  echo "Example: $0 'Hello World'"
  exit 1
}

# Check if a parameter is provided
if [ $# -eq 0 ]; then
  echo "Error: No parameter provided."
  usage
fi

# Store the parameter in a variable
autoopflag="$1"

# Function to process the parameter
process_parameter() {
  local input="$1"
  # echo "The parameter you provided is: $input"
  # echo "Processing the parameter..."
  # Add your processing logic here
  # echo "Parameter processed successfully!"
  if [ "$input" == "-y" ]; then
    echo "The parameter you provided is: $input"
  else
    echo "Error: Invalid parameter provided."
    usage
  fi
}

# Call the function with the provided parameter
process_parameter "$autoopflag"

echo now we will install basic apps , N to skip

if [ "$autoopflag" != "-y" ]; then
  read -rp "ok? (y/N): " yn
else
  yn="y"
fi
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

  if [ "$autoopflag" != "-y" ]; then
    #ask user if they want to instal the additional apps
    read -rp "install additional apps? (y/N): " yn
  else
    yn="y"
  fi
  case "$yn" in [yY]*) #this is the condition yes
    #installing additional apps
    ./misc/aptinit.sh
    ./misc/fontinit.sh
    ./misc/rdp/remotedesktopsetup.sh

    if [ "$autoopflag" != "-y" ]; then
      #ask user if they want to install snap apps
      read -rp "install snap apps? (y/N): " yn
    else
      yn="y"
    fi
    case "$yn" in [yY]*) #this is the condition yes
      #installing snap apps
      ./misc/snapinit.sh
      ./misc/installgooglechrome.sh
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
if [ "$autoopflag" != "-y" ]; then
  echo this will overwrite the setting on this user ....

  read -rp "ok? (y/N): " yn
else
  yn="y"
fi

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
