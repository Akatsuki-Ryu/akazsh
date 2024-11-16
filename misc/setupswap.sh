#!/bin/bash

# Default swap size in GB
DEFAULT_SIZE=4
SWAP_SIZE=${1:-$DEFAULT_SIZE}

# judge if running in linux
if [ "$(uname)" != "Linux" ]; then
    echo "This script is only for Linux"
    exit 1
fi

# Function to create or resize swap
create_or_resize_swap() {
    local size=$1
    echo "Creating/Resizing to ${size}GB swap file..."
    
    # Turn off swap if it's active
    sudo swapoff /swapfile 2>/dev/null
    
    # Calculate count based on swap size (128M blocks)
    COUNT=$((size * 8))  # 8 blocks of 128M = 1GB
    
    # Create/Resize swap file
    sudo dd if=/dev/zero of=/swapfile bs=128M count=$COUNT
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo swapon -s
    
    # Add to /etc/fstab if not already present
    if ! grep -q "/swapfile swap swap defaults 0 0" /etc/fstab; then
        echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
    fi
    
    echo "Swap file of ${size}GB created/resized and configured"
}

# Check if swap file exists
if [ -f /swapfile ]; then
    CURRENT_SIZE=$(sudo du -h /swapfile | awk '{print $1}' | sed 's/G//')
    echo "Swap file already exists with size ${CURRENT_SIZE}GB"
    read -p "Do you want to resize it to ${SWAP_SIZE}GB? (y/n): " RESIZE
    if [ "$RESIZE" = "y" ] || [ "$RESIZE" = "Y" ]; then
        create_or_resize_swap $SWAP_SIZE
    else
        echo "Keeping existing swap file"
        exit 0
    fi
else
    create_or_resize_swap $SWAP_SIZE
fi
