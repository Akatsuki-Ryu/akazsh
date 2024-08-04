#!/bin/bash
# install DroidSansMono Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
unzip Hack.zip -d ~/.fonts
fc-cache -fv
echo "done!"
