#!/bin/bash

# List all installed snap packages
snap_list=$(snap list | awk '!/^Name|^core|^bare/ {print $1}')

# Uninstall each snap package
for package in $snap_list; do
    echo "Removing Snap package: $package"
    sudo snap remove "$package"
done

# Stop the snapd service
echo "Stopping snapd service"
sudo systemctl stop snapd

# Remove the snapd package
echo "Removing snapd package"
sudo apt remove --purge -y snapd

# Delete the /snap directory
echo "Removing /snap directory"
sudo rm -rf /snap

echo "All Snap packages are removed and /snap directory is deleted."