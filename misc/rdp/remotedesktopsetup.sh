#!/bin/bash

# Update package list and install required packages
sudo apt update
sudo apt install -y xfce4 xfce4-goodies xrdp

# Configure XRDP
sudo adduser xrdp ssl-cert
sudo systemctl enable xrdp
sudo systemctl start xrdp

# Clean up any existing .xsessionrc file
sudo rm -f ~/.xsessionrc

# write .xsessionrc to ~/ as root user
# echo 'export GNOME_SHELL_SESSION_MODE=ubuntu' | sudo tee ~/.xsessionrc
# echo "export XDG_CURRENT_DESKTOP=ubuntu:GNOME" | sudo tee ~/.xsessionrc
# it turned out the performance of having this xsessionrc file is not good

sudo systemctl restart xrdp

echo "Remote desktop setup complete. Please reboot your system."
