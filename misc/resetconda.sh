#!/bin/bash

# judge if running in macos
if [ "$(uname)" != "Darwin" ]; then
    echo "This script is only for MacOS"
    exit 1
fi

# Define the Miniconda installer URL
INSTALLER_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
INSTALLER_PATH="$HOME/miniconda3-installer.sh"

# Function to print messages
function echo_msg {
  echo -e "\n====> $1\n"
}

# Uninstall Miniconda
echo_msg "Removing existing Miniconda installation and associated files..."
rm -rf ~/miniconda3 ~/.conda ~/.continuum ~/.condarc

# Unset Miniconda PATH
echo_msg "Removing Miniconda from PATH in shell profiles..."
sed -i '' '/miniconda3/d' ~/.bashrc ~/.bash_profile ~/.zshrc 2>/dev/null

# check if the installation file exists
if [ -f "$INSTALLER_PATH" ]; then
  echo_msg "Installer file already exists. Skipping download."
else
  # Download and install Miniconda
  echo_msg "Downloading Miniconda installer..."
  curl -o "$INSTALLER_PATH" "$INSTALLER_URL"
fi

echo_msg "Running Miniconda installer..."
bash "$INSTALLER_PATH" -b -p "$HOME/miniconda3"

# Remove installer
echo_msg "Cleaning up installer file..."
rm -f "$INSTALLER_PATH"

# Initialize Miniconda
echo_msg "Initializing Miniconda..."
source "$HOME/miniconda3/bin/activate"
conda init

echo_msg "Miniconda has been reinstalled and initialized. Please restart your terminal session or run 'source ~/.bashrc' or equivalent for changes to take effect."
