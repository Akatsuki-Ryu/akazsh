#!/bin/bash

# Use the intelligent distribution from the main script
# with 150MB default size

source ~/akazsh/misc/zip_split_passwd.sh

echo "=== Optimized 150MB Zip Splitter ==="
echo ""

# Get the current directory name as default filename
default_filename=$(basename "$(pwd)")
echo "Base name for subfolders (default: $default_filename):"
read filename
filename=${filename:-$default_filename}

echo "Input the package password (default: zheshiyigexinwen):"
read password
password=${password:-zheshiyigexinwen}

# Use 150MB as the fixed size
max_size="150m"
max_size_bytes=$(size_to_bytes "$max_size")

echo "Using fixed size: 150MB ($(numfmt --to=iec $max_size_bytes) bytes)"
echo ""

organize_into_subfolders $max_size_bytes $filename $password

