#!/bin/bash
#judge if running in linux
if [ "$(uname)" != "Linux" ]; then
    echo "This script is only for Linux"
    exit 1
fi

# judge if the swap file already exists
if [ -f /swapfile ]; then
    echo "Swap file already exists"
    exit 0
fi


# Create a 4GB swap file
sudo dd if=/dev/zero of=/swapfile bs=128M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon -s

# Add the swap file to /etc/fstab
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab

echo "Swap file created and added to /etc/fstab"
