sudo apt install xfce4 xfce4-goodies -y
sudo apt install xrdp -y
sudo systemctl start xrdp
sudo adduser xrdp ssl-cert

sudo rm -rf ~/.xsessionrc
# sudo touch ~/.xsessionrc

# write .xsessionrc to ~/ as root user
# echo 'export GNOME_SHELL_SESSION_MODE=ubuntu' | sudo tee ~/.xsessionrc
# echo "export XDG_CURRENT_DESKTOP=ubuntu:GNOME" | sudo tee ~/.xsessionrc
# it turned out the performance of having this xsessionrc file is not good

sudo systemctl restart xrdp
