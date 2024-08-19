#!/bin/bash

# Get the current username
username=$(whoami)

# Check if sambashare directory exists, create it if it doesn't
sambashare_dir="/home/$username/sambashare"
if [ ! -d "$sambashare_dir" ]; then
  echo "Creating sambashare directory..."
  mkdir "$sambashare_dir"
else
  echo "Sambashare directory already exists."
fi

# Add the share configuration to smb.conf
sudo tee -a /etc/samba/smb.conf <<EOF

[sambashare]
    comment = Samba on Ubuntu
    path = $sambashare_dir
    read only = no
    browsable = yes
EOF

# Restart Samba service
sudo service smbd restart

# Update firewall rules
sudo ufw allow samba

echo "Samba setup completed for user: $username"
