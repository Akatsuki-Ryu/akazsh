#!/bin/bash

# check first which os it is running
# if it is ubuntu , then continue

if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$NAME
  VER=$VERSION_ID
fi
if [ "$OS" != "Ubuntu" ]; then
  echo "This script is only for Ubuntu"
  exit 1
fi

# Check if the script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo privileges."
  exit 1
fi

# Path to the GRUB configuration file
GRUB_CONFIG="/etc/default/grub"

# Backup the original GRUB configuration file
cp "$GRUB_CONFIG" "${GRUB_CONFIG}.bak"

# Add or update the GRUB_CMDLINE_LINUX_DEFAULT parameter
if grep -q "^GRUB_CMDLINE_LINUX_DEFAULT=" "$GRUB_CONFIG"; then
  # If the line exists, update it
  sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on quiet splash"/' "$GRUB_CONFIG"
else
  # If the line doesn't exist, add it
  echo 'GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on quiet splash"' >>"$GRUB_CONFIG"
fi

# Update GRUB
update-grub

echo "GRUB configuration updated successfully."
echo "A backup of the original configuration has been saved as ${GRUB_CONFIG}.bak"

# install kvm components
sudo apt install qemu-system-x86 libvirt-clients libvirt-daemon-system libvirt-daemon-config-network bridge-utils virt-manager ovmf

#!/bin/bash

# Check if the script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo privileges."
  exit 1
fi

# Path to the libvirtd.conf file
LIBVIRTD_CONF="/etc/libvirt/libvirtd.conf"

# Backup the original configuration file
cp "$LIBVIRTD_CONF" "${LIBVIRTD_CONF}.bak"

# Function to uncomment a line in the file
uncomment_line() {
  local search="$1"
  sed -i "s/^#*\s*$search/$search/" "$LIBVIRTD_CONF"
}

# Function to add a line to the end of the file if it doesn't exist
add_line_if_not_exists() {
  local line="$1"
  grep -qF -- "$line" "$LIBVIRTD_CONF" || echo "$line" >>"$LIBVIRTD_CONF"
}

# Uncomment the specified lines
uncomment_line 'unix_sock_group = "libvirt"'
uncomment_line 'unix_sock_rw_perms = "0770"'

# Add logging configuration
add_line_if_not_exists 'log_filters="3:qemu 1:libvirt"'
add_line_if_not_exists 'log_outputs="2:file:/var/log/libvirt/libvirtd.log"'

echo "libvirtd.conf has been updated successfully."
echo "A backup of the original configuration has been saved as ${LIBVIRTD_CONF}.bak"

# Ensure the log directory exists
mkdir -p /var/log/libvirt

# Set appropriate permissions for the log directory
chown root:root /var/log/libvirt
chmod 755 /var/log/libvirt

# Add the current user to the kvm and libvirt groups
CURRENT_USER=$(logname)
usermod -a -G kvm,libvirt "$CURRENT_USER"
echo "User $CURRENT_USER has been added to the kvm and libvirt groups."

# Enable and start the libvirtd service
systemctl enable libvirtd
systemctl start libvirtd

echo "The libvirtd service has been enabled and started."
echo "Configuration complete. Please log out and log back in for group changes to take effect."

#!/bin/bash

# Check if the script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo privileges."
  exit 1
fi

# Path to the libvirtd.conf file
LIBVIRTD_CONF="/etc/libvirt/libvirtd.conf"
# Path to the qemu.conf file
QEMU_CONF="/etc/libvirt/qemu.conf"

# Function to uncomment and replace a line in the file
uncomment_and_replace() {
  local search="$1"
  local replace="$2"
  local file="$3"
  sed -i "s/^#*\s*$search.*/$replace/" "$file"
}

# Function to add a line to the end of the file if it doesn't exist
add_line_if_not_exists() {
  local line="$1"
  local file="$2"
  grep -qF -- "$line" "$file" || echo "$line" >>"$file"
}

# Get the current non-root user
CURRENT_USER=$(logname)

# Backup and modify libvirtd.conf
cp "$LIBVIRTD_CONF" "${LIBVIRTD_CONF}.bak"
uncomment_and_replace 'unix_sock_group = "libvirt"' 'unix_sock_group = "libvirt"' "$LIBVIRTD_CONF"
uncomment_and_replace 'unix_sock_rw_perms = "0770"' 'unix_sock_rw_perms = "0770"' "$LIBVIRTD_CONF"
add_line_if_not_exists 'log_filters="3:qemu 1:libvirt"' "$LIBVIRTD_CONF"
add_line_if_not_exists 'log_outputs="2:file:/var/log/libvirt/libvirtd.log"' "$LIBVIRTD_CONF"

# Backup and modify qemu.conf
cp "$QEMU_CONF" "${QEMU_CONF}.bak"
uncomment_and_replace 'user = "root"' "user = \"$CURRENT_USER\"" "$QEMU_CONF"
uncomment_and_replace 'group = "root"' "group = \"$CURRENT_USER\"" "$QEMU_CONF"

echo "Configuration files have been updated successfully."
echo "Backups of the original configurations have been saved as ${LIBVIRTD_CONF}.bak and ${QEMU_CONF}.bak"

# Ensure the log directory exists
mkdir -p /var/log/libvirt

# Set appropriate permissions for the log directory
chown root:root /var/log/libvirt
chmod 755 /var/log/libvirt

# Add the current user to the kvm and libvirt groups
usermod -a -G kvm,libvirt "$CURRENT_USER"
echo "User $CURRENT_USER has been added to the kvm and libvirt groups."

# Enable and start the libvirtd service
systemctl enable libvirtd
systemctl start libvirtd

echo "The libvirtd service has been enabled and started."
echo "Configuration complete. Please log out and log back in for group changes to take effect."

# virtual network setup
sudo virsh net-autostart default
