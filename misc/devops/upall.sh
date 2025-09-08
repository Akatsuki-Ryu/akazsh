#st!/bin/bash

# Function to create or attach to tmux session
init_tmux_session() {
  local window_type=$1 # 'updates' only

  if [ -z "$TMUX" ]; then
    # Create session with updates window
    tmux new-session -d -s akaboxsession -n 'updates'

    # Create update panes
    tmux split-window -h
    tmux split-window -h
    tmux select-layout even-horizontal
  fi
}

# Function to run system updates on a list of machines with OS-specific commands
update_machines() {
  local with_reboot=$1
  local machines_file=$2
  local os_type=$3

  # Check if machines file exists
  if [ ! -f "$machines_file" ]; then
    echo "Error: $machines_file not found!"
    echo "Please create $machines_file with one server address per line"
    exit 1
  fi

  # Count total machines
  total_machines=0
  while IFS= read -r machine; do
    if [ ! -z "$(echo "$machine" | tr -d '[:space:]')" ]; then
      ((total_machines++))
    fi
  done <"$machines_file"

  echo "Found $total_machines $os_type machines to update in $machines_file"

  # Initialize tmux with updates window and panes
  init_tmux_session "updates"

  # Calculate number of additional panes needed
  additional_panes_needed=$((total_machines - 3))

  # Create additional panes if needed
  if [ "$additional_panes_needed" -gt 0 ]; then
    for i in $(seq 1 $additional_panes_needed); do
      tmux split-window -h
    done
    tmux select-layout tiled
  fi

  # Update machines using all panes
  current_pane=0
  updated_machines=0

  while IFS= read -r machine; do
    # Trim whitespace
    machine=$(echo "$machine" | tr -d '[:space:]')
    if [ ! -z "$machine" ]; then
      ((updated_machines++))

      # Select the appropriate pane
      tmux select-pane -t akaboxsession:updates.$current_pane

      # Send update commands to the pane based on OS type
      tmux send-keys "echo '=== Updating $os_type machine: $machine === ($updated_machines of $total_machines)'" C-m

      if [ "$os_type" = "linux" ]; then
        # Linux update commands
        if [ "$with_reboot" = true ]; then
          tmux send-keys "ssh -t \"$machine\" 'sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && echo \"Updates completed, rebooting in 5 seconds...\" && sleep 5 && sudo reboot'" C-m
        else
          tmux send-keys "ssh -t \"$machine\" 'sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y'" C-m
        fi
      elif [ "$os_type" = "mac" ]; then
        # Mac update commands
        if [ "$with_reboot" = true ]; then
          tmux send-keys "ssh -t \"$machine\" 'softwareupdate -i -a && echo \"Updates completed, rebooting in 5 seconds...\" && sleep 5 && sudo reboot'" C-m
        else
          tmux send-keys "ssh -t \"$machine\" 'softwareupdate -i -a'" C-m
        fi
      else
        tmux send-keys "echo 'Unknown OS type: $os_type for $machine. Skipping.'" C-m
      fi

      # Move to next pane
      ((current_pane++))
    fi
  done <"$machines_file"

  # Attach to tmux session if we created it
  if [ -z "$TMUX" ]; then
    tmux attach-session -t akaboxsession
  fi
}

# Function to update both Linux and Mac machines
update_all_machines() {
  local with_reboot=$1
  local linux_file="./serverlist_linux.txt"
  local mac_file="./serverlist_mac.txt"

  # Check if at least one of the files exists
  if [ ! -f "$linux_file" ] && [ ! -f "$mac_file" ]; then
    echo "Error: Neither $linux_file nor $mac_file found!"
    echo "Please create at least one of these files with server addresses (one per line)"
    exit 1
  fi

  # Update Linux machines if the file exists
  if [ -f "$linux_file" ]; then
    echo "Updating Linux machines from $linux_file"
    update_machines "$with_reboot" "$linux_file" "linux"
  fi

  # Update Mac machines if the file exists
  if [ -f "$mac_file" ]; then
    echo "Updating Mac machines from $mac_file"
    update_machines "$with_reboot" "$mac_file" "mac"
  fi
}

# Check command line arguments
case "$1" in
"--update-machines" | "-um")
  if [ -z "$2" ]; then
    echo "Error: No machines file specified."
    echo "Usage: $0 --update-machines <machines_file> [--no-reboot] [--os-type <linux|mac>]"
    exit 1
  fi

  machines_file="$2"
  with_reboot=true
  os_type="linux" # Default to Linux

  # Process additional flags
  shift 2
  while [ "$#" -gt 0 ]; do
    case "$1" in
    "--no-reboot")
      with_reboot=false
      ;;
    "--os-type")
      if [ -z "$2" ]; then
        echo "Error: No OS type specified after --os-type"
        exit 1
      fi
      os_type="$2"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
    esac
    shift
  done

  if [ "$with_reboot" = true ]; then
    echo "This will update all $os_type machines in $machines_file and restart them after updates."
    echo "All machines will reboot 5 seconds after updates complete."
  else
    echo "This will update all $os_type machines in $machines_file WITHOUT rebooting them."
  fi

  read -p "Are you sure you want to continue? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    update_machines "$with_reboot" "$machines_file" "$os_type"
  fi
  ;;
"--update-all" | "-ua")
  with_reboot=true

  # Check for --no-reboot flag
  if [ "$2" = "--no-reboot" ]; then
    with_reboot=false
    echo "This will update all Linux and Mac machines WITHOUT rebooting them."
  else
    echo "This will update all Linux and Mac machines and restart them after updates."
    echo "All machines will reboot 5 seconds after updates complete."
  fi

  read -p "Are you sure you want to continue? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    update_all_machines "$with_reboot"
  fi
  ;;
"--help" | "-h")
  echo "Usage: $0 [OPTION]"
  echo "Update system packages on Linux and Mac machines"
  echo ""
  echo "Options:"
  echo "  --update-machines, -um <file>     Run system updates on machines listed in <file>"
  echo "                                    [--no-reboot] - Optional flag to skip rebooting"
  echo "                                    [--os-type <linux|mac>] - Specify OS type (default: linux)"
  echo "  --update-all, -ua                 Update all machines in serverlist_linux and serverlist_mac"
  echo "                                    [--no-reboot] - Optional flag to skip rebooting"
  echo "  --help, -h                        Display this help message"
  echo ""
  echo "Examples:"
  echo "  $0 --update-all                   Update all Linux and Mac machines with reboot"
  echo "  $0 --update-all --no-reboot       Update all machines without rebooting"
  echo "  $0 --update-machines custom.txt --os-type mac   Update Mac machines in custom.txt"
  exit 0
  ;;
*)
  # Default to showing help
  echo "Usage: $0 [OPTION]"
  echo "Update system packages on Linux and Mac machines"
  echo ""
  echo "For more information, use: $0 --help"
  exit 1
  ;;
esac

