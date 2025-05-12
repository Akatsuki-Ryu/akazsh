#!/bin/bash

# Default variables
DEFAULT_REMOTE_USER="ubuntu"
DEFAULT_REMOTE_HOST="box"
DEFAULT_REMOTE_PATH="~/"
DEFAULT_LOCAL_PATH="."

# Function to display header
show_header() {
  clear
  echo "=========================================="
  echo "    RSYNC FILE SYNC WITH PERMISSIONS"
  echo "=========================================="
  echo
}

# Function to get user input with default value
get_input() {
  local prompt="$1"
  local default="$2"
  local input
  
  read -p "$prompt [$default]: " input
  echo "${input:-$default}"
}

# Function to get source directory name
get_source_dir_name() {
  local path="$1"
  local dir_name
  
  # Handle the case when path is "." (current directory)
  if [[ "$path" == "." ]]; then
    dir_name=$(basename "$(pwd)")
  else
    # Remove trailing slash if present
    path=${path%/}
    dir_name=$(basename "$path")
  fi
  
  echo "$dir_name"
}

# Interactive menu
show_header
echo "Please configure your sync settings:"
echo "-----------------------------------"
REMOTE_USER=$(get_input "Remote username" "$DEFAULT_REMOTE_USER")
REMOTE_HOST=$(get_input "Remote host" "$DEFAULT_REMOTE_HOST")
REMOTE_PATH=$(get_input "Remote path" "$DEFAULT_REMOTE_PATH")
LOCAL_PATH=$(get_input "Local path" "$DEFAULT_LOCAL_PATH")

# Get source directory name for creating remote folder
SOURCE_DIR_NAME=$(get_source_dir_name "$LOCAL_PATH")
REMOTE_TARGET_PATH="${REMOTE_PATH%/}/${SOURCE_DIR_NAME}"

# Confirm settings
show_header
echo "SYNC CONFIGURATION:"
echo "-----------------------------------"
echo "From: $LOCAL_PATH/"
echo "To: $REMOTE_USER@$REMOTE_HOST:$REMOTE_TARGET_PATH"
echo "Source directory name: $SOURCE_DIR_NAME"
echo
read -p "Proceed with these settings? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Operation cancelled."
  exit 0
fi

# Show progress
echo
echo "Starting sync operation..."
echo "-----------------------------------"

# Step 1: Create directory on remote server
echo "Step 1: Creating directory on remote server..."
ssh "$REMOTE_USER@$REMOTE_HOST" "mkdir -p $REMOTE_TARGET_PATH"

# Step 2: Sync files from local directory to remote server with sudo permissions
echo "Step 2: Syncing files to remote server..."
sudo rsync -avz --rsync-path="sudo rsync" "$LOCAL_PATH/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_TARGET_PATH"

# Step 3: Fix permissions on remote server
echo "Step 3: Fixing file permissions on remote server..."
# Commented out permission fixing
# ssh "$REMOTE_USER@$REMOTE_HOST" "sudo find $REMOTE_TARGET_PATH -user root -exec chown $REMOTE_USER:$REMOTE_USER {} \;"
echo "Note: Permission fixing is currently disabled."

echo
echo "=========================================="
echo "    SYNC OPERATION COMPLETE"
echo "=========================================="