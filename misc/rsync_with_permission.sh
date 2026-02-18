#!/bin/bash

# Default variables
DEFAULT_REMOTE_USER="ubuntu"
DEFAULT_REMOTE_HOST="box"
DEFAULT_REMOTE_PATH="~/"
DEFAULT_LOCAL_PATH="."

# Host list file path
HOST_LIST_FILE="$(dirname "$0")/remote_hosts.txt"

# Function to load host list from file
load_host_list() {
  local hosts=()
  local host_file="$1"
  
  if [[ ! -f "$host_file" ]]; then
    echo "Warning: Host list file '$host_file' not found. Using default hosts only." >&2
    return 1
  fi
  
  while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
      continue
    fi
    
    # Parse format: username:hostname:remote_path:description
    if [[ "$line" =~ ^([^:]+):([^:]+):([^:]+):(.+)$ ]]; then
      hosts+=("${BASH_REMATCH[1]}:${BASH_REMATCH[2]}:${BASH_REMATCH[3]}:${BASH_REMATCH[4]}")
    fi
  done < "$host_file"
  
  printf '%s\n' "${hosts[@]}"
}

# Function to display header
show_header() {
  clear
  echo "=========================================="
  echo "    RSYNC FILE SYNC WITH PERMISSIONS"
  echo "=========================================="
  echo
}

# Function to display help
show_help() {
  echo "Usage: $0 [OPTIONS]"
  echo
  echo "Options:"
  echo "  -a, --auto                Run in automatic mode with default values"
  echo "  -u, --user USER           Remote username (default: $DEFAULT_REMOTE_USER)"
  echo "  -h, --host HOST           Remote host (default: $DEFAULT_REMOTE_HOST)"
  echo "  -r, --remote-path PATH    Remote path (default: $DEFAULT_REMOTE_PATH)"
  echo "  -l, --local-path PATH     Local path (default: $DEFAULT_LOCAL_PATH)"
  echo "  -s, --server ID           Choose server from host list by ID (1-based, enables auto mode)"
  echo "  --cyber24                 Quick sync to cyber24 host with akatsuki user"
  echo "  --help                    Display this help message"
  echo
  echo "Host Configuration:"
  echo "  The script loads remote hosts from: $HOST_LIST_FILE"
  echo "  Format: username:hostname:remote_path:description"
  echo "  Lines starting with # are comments"
  echo
  exit 0
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

# Parse command line arguments
AUTO_MODE=false
SERVER_ID=""
REMOTE_USER="$DEFAULT_REMOTE_USER"
REMOTE_HOST="$DEFAULT_REMOTE_HOST"
REMOTE_PATH="$DEFAULT_REMOTE_PATH"
LOCAL_PATH="$DEFAULT_LOCAL_PATH"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -a|--auto)
      AUTO_MODE=true
      shift
      ;;
    -u|--user)
      REMOTE_USER="$2"
      shift 2
      ;;
    -h|--host)
      REMOTE_HOST="$2"
      shift 2
      ;;
    -r|--remote-path)
      REMOTE_PATH="$2"
      shift 2
      ;;
    -l|--local-path)
      LOCAL_PATH="$2"
      shift 2
      ;;
    -s|--server)
      SERVER_ID="$2"
      shift 2
      ;;
    --cyber24)
      REMOTE_HOST="cyber24"
      REMOTE_USER="akatsuki"
      AUTO_MODE=true
      shift
      ;;
    --help)
      show_help
      ;;
    *)
      echo "Error: Unknown option '$1'"
      show_help
      ;;
  esac
done

# Handle server selection for auto mode
if [[ -n "$SERVER_ID" ]]; then
  hosts=($(load_host_list "$HOST_LIST_FILE"))
  if [[ ${#hosts[@]} -eq 0 ]]; then
    echo "Error: No hosts available in $HOST_LIST_FILE"
    exit 1
  fi
  if [[ "$SERVER_ID" =~ ^[0-9]+$ && "$SERVER_ID" -ge 1 && "$SERVER_ID" -le ${#hosts[@]} ]]; then
    IFS=':' read -r REMOTE_USER REMOTE_HOST REMOTE_PATH DESC <<< "${hosts[$((SERVER_ID-1))]}"
    AUTO_MODE=true
  else
    echo "Error: Invalid server ID '$SERVER_ID'. Must be between 1 and ${#hosts[@]}"
    exit 1
  fi
fi

# If not in auto mode, run interactive menu
if [ "$AUTO_MODE" = false ]; then
  show_header
  
  # Load hosts from external file
  echo "Available Remote Hosts:"
  echo "-----------------------------------"
  
  # Load and display hosts from file
  host_count=0
  declare -a host_array
  declare -a user_array
  declare -a path_array
  declare -a desc_array
  
  while IFS= read -r host_line; do
    if [[ -n "$host_line" ]]; then
      IFS=':' read -r user host path desc <<< "$host_line"
      host_count=$((host_count + 1))
      host_array+=("$host")
      user_array+=("$user")
      path_array+=("$path")
      desc_array+=("$desc")
      echo "$host_count) $desc ($user@$host:$path)"
    fi
  done < <(load_host_list "$HOST_LIST_FILE")
  
  # Add default options
  host_count=$((host_count + 1))
  echo "$host_count) Custom configuration"
  host_count=$((host_count + 1))
  echo "$host_count) Use default (ubuntu@box)"
  
  echo
  read -p "Select a host (1-$host_count): " host_option
  
  # Validate selection
  if [[ "$host_option" =~ ^[0-9]+$ ]] && [ "$host_option" -ge 1 ] && [ "$host_option" -le "$host_count" ]; then
    total_hosts=${#host_array[@]}
    
    if [ "$host_option" -le "$total_hosts" ]; then
      # Selected from external list
      selected_index=$((host_option - 1))
      REMOTE_HOST="${host_array[$selected_index]}"
      REMOTE_USER="${user_array[$selected_index]}"
      REMOTE_PATH="${path_array[$selected_index]}"
      LOCAL_PATH=$(get_input "Local path" "$LOCAL_PATH")
    elif [ "$host_option" -eq $((total_hosts + 1)) ]; then
      # Custom configuration
      echo
      echo "Please configure your sync settings:"
      echo "-----------------------------------"
      REMOTE_USER=$(get_input "Remote username" "$REMOTE_USER")
      REMOTE_HOST=$(get_input "Remote host" "$REMOTE_HOST")
      REMOTE_PATH=$(get_input "Remote path" "$REMOTE_PATH")
      LOCAL_PATH=$(get_input "Local path" "$LOCAL_PATH")
    else
      # Use default
      REMOTE_HOST="$DEFAULT_REMOTE_HOST"
      REMOTE_USER="$DEFAULT_REMOTE_USER"
      LOCAL_PATH=$(get_input "Local path" "$LOCAL_PATH")
      REMOTE_PATH=$(get_input "Remote path" "$REMOTE_PATH")
    fi
  else
    echo "Invalid selection. Using default configuration."
    REMOTE_HOST="$DEFAULT_REMOTE_HOST"
    REMOTE_USER="$DEFAULT_REMOTE_USER"
    LOCAL_PATH=$(get_input "Local path" "$LOCAL_PATH")
    REMOTE_PATH=$(get_input "Remote path" "$REMOTE_PATH")
  fi
fi

# Get source directory name for creating remote folder
SOURCE_DIR_NAME=$(get_source_dir_name "$LOCAL_PATH")
REMOTE_TARGET_PATH="${REMOTE_PATH%/}/${SOURCE_DIR_NAME}"

# If not in auto mode, show confirmation
if [ "$AUTO_MODE" = false ]; then
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
else
  # In auto mode, just show the configuration
  echo "SYNC CONFIGURATION (Automatic Mode):"
  echo "-----------------------------------"
  echo "From: $LOCAL_PATH/"
  echo "To: $REMOTE_USER@$REMOTE_HOST:$REMOTE_TARGET_PATH"
  echo "Source directory name: $SOURCE_DIR_NAME"
  echo
fi

# Show progress
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