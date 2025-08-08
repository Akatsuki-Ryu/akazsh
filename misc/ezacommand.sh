#!/bin/bash

# Color codes
green='\033[0;32m'
reset='\033[0m'

# Source aliases to ensure fd works cross-platform
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

eza --long --tree -abghHS -s modified --icons --color always --color-scale "$@"

echo

folder_size=$(du -sh . | cut -f1)
file_count_recursive=$(fd . --type f | wc -l)
file_count_current=$(fd . --maxdepth 1 --type f | wc -l)

label_width=50   # increased width for more space

printf "%-${label_width}s %10b\n" "Current folder size (including subfolders):" "${green}${folder_size}${reset}"
printf "%-${label_width}s %10b\n" "File count (recursive):" "${green}${file_count_recursive}${reset}"
printf "%-${label_width}s %10b\n" "File count (current folder only):" "${green}${file_count_current}${reset}"