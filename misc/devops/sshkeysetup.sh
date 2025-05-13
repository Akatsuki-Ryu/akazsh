#!/bin/bash

# Script to set up passwordless sudo for a specified user and add SSH public key
# Usage: ./sshsetup.sh [username]
# If no username is provided, the current user will be used

# Default SSH public key to add as a fallback
DEFAULT_SSH_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDRkZAY4OelJ6E+fFAiKEaqf9pWtveiBYhgTVvd90p37JpIQJ4H90vAxOc2Cscr7pUzoOh1ki5T5m/RLJTJz4JTzRZ+PBDm+sdc9z12zFeBHgKGLyTqiLqQsfRPpHGqYWdKOzUyqbP9yg227/0QkTahOZX/u03Yf5cuhkJQNTV8hw== akatsuki@belmondopro.local"

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root or with sudo privileges."
    exit 1
fi

# Check if username is provided
if [ $# -eq 0 ]; then
    # Get the username of the user who invoked sudo (or current user if run as root directly)
    if [ -n "$SUDO_USER" ]; then
        USERNAME="$SUDO_USER"
    else
        USERNAME="$(logname 2>/dev/null || whoami)"
    fi
    echo "No username provided, using current user: $USERNAME"
else
    USERNAME="$1"
fi

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi

# Get the user's home directory
USER_HOME=$(eval echo ~$USERNAME)

# Set up passwordless sudo
# Create a sudoers file entry for the user
SUDOERS_ENTRY="$USERNAME ALL=(ALL) NOPASSWD: ALL"

# Check if entry already exists
if grep -q "^$USERNAME.*NOPASSWD: ALL" /etc/sudoers; then
    echo "User '$USERNAME' already has passwordless sudo privileges."
else
    # Add the entry to the sudoers file using a safer method
    echo "$SUDOERS_ENTRY" > "/etc/sudoers.d/$USERNAME"
    chmod 0440 "/etc/sudoers.d/$USERNAME"
    echo "Passwordless sudo privileges granted to user '$USERNAME'."
fi

# Set up SSH key for the user
SSH_DIR="$USER_HOME/.ssh"
AUTH_KEYS_FILE="$SSH_DIR/authorized_keys"

# Create .ssh directory if it doesn't exist
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chown "$USERNAME:$(id -gn "$USERNAME")" "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    echo "Created SSH directory: $SSH_DIR"
fi

# Add the default SSH key if it's not already in authorized_keys
if [ ! -f "$AUTH_KEYS_FILE" ] || ! grep -q "$DEFAULT_SSH_KEY" "$AUTH_KEYS_FILE"; then
    echo "$DEFAULT_SSH_KEY" >> "$AUTH_KEYS_FILE"
    chown "$USERNAME:$(id -gn "$USERNAME")" "$AUTH_KEYS_FILE"
    chmod 600 "$AUTH_KEYS_FILE"
    echo "Added default SSH public key to $AUTH_KEYS_FILE"
else
    echo "Default SSH key already exists in $AUTH_KEYS_FILE"
fi

# Verify the sudo changes
echo "Verifying configuration..."
if [ -f "/etc/sudoers.d/$USERNAME" ]; then
    echo "Sudo configuration successful: User '$USERNAME' can now use sudo without a password."
else
    echo "Error: Sudo configuration failed."
    exit 1
fi

# Verify SSH key configuration
if [ -f "$AUTH_KEYS_FILE" ] && grep -q "$DEFAULT_SSH_KEY" "$AUTH_KEYS_FILE"; then
    echo "SSH key configuration successful: Default SSH key has been added."
else
    echo "Error: SSH key configuration failed."
    exit 1
fi

echo "Setup complete for user '$USERNAME'"
exit 0
