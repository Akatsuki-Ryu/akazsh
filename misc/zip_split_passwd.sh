#!/bin/bash

# Function to convert size to bytes
size_to_bytes() {
    local size=$1
    local unit=${size: -1}
    local number=${size%?}
    
    case $unit in
        [mM]) echo $((number * 1024 * 1024)) ;;
        [gG]) echo $((number * 1024 * 1024 * 1024)) ;;
        [kK]) echo $((number * 1024)) ;;
        *) echo $number ;;
    esac
}

# Function to get file size in bytes
get_file_size() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        stat -f%z "$1" 2>/dev/null || echo 0
    else
        # Linux
        stat -c%s "$1" 2>/dev/null || echo 0
    fi
}

# Function to organize files into subfolders by size
organize_into_subfolders() {
    local max_size_bytes=$1
    local base_name=$2
    local password=$3
    
    echo "Organizing files into subfolders..."
    
    # Create a temporary directory to work in
    temp_dir="temp_organize_$$"
    mkdir -p "$temp_dir"
    
    # Get all files (excluding directories and hidden files)
    # Use while loop with null delimiter to handle filenames with spaces properly
    declare -a files
    while IFS= read -r -d '' file; do
        files+=("$file")
    done < <(find . -maxdepth 1 -type f ! -name ".*" ! -name "$(basename "$0")" ! -name "$temp_dir" -print0 | sort -z)
    
    if [ ${#files[@]} -eq 0 ]; then
        echo "No files found to organize."
        rmdir "$temp_dir"
        return 1
    fi
    
    local current_folder_num=1
    local current_folder_size=0
    local current_folder_name="${base_name}_vol${current_folder_num}"
    
    # Create first subfolder
    mkdir -p "$temp_dir/$current_folder_name"
    
    echo "Distributing files into subfolders (max size: $max_size_bytes bytes)..."
    
    for file in "${files[@]}"; do
        file_size=$(get_file_size "$file")
        
        # Check if adding this file would exceed the size limit
        if [ $((current_folder_size + file_size)) -gt $max_size_bytes ] && [ $current_folder_size -gt 0 ]; then
            echo "Folder $current_folder_name: $(numfmt --to=iec $current_folder_size)"
            
            # Create next folder
            current_folder_num=$((current_folder_num + 1))
            current_folder_name="${base_name}_vol${current_folder_num}"
            mkdir -p "$temp_dir/$current_folder_name"
            current_folder_size=0
        fi
        
        # Copy file to current subfolder
        if cp "$file" "$temp_dir/$current_folder_name/"; then
            current_folder_size=$((current_folder_size + file_size))
            echo "Added $(basename "$file") to $current_folder_name"
        else
            echo "Error: Failed to copy $(basename "$file")"
        fi
    done
    
    echo "Folder $current_folder_name: $(numfmt --to=iec $current_folder_size)"
    echo ""
    echo "Created $current_folder_num subfolders."
    
    # Zip each subfolder
    echo "Creating zip files for each subfolder..."
    cd "$temp_dir"
    
    # First, create all zip files with temporary names
    for folder in ${base_name}_vol*; do
        if [ -d "$folder" ]; then
            echo "Zipping $folder..."
            zip -r -P "$password" "../${folder}.zip" "$folder"
            echo "Created ${folder}.zip"
        fi
    done
    
    cd ..
    
    # Now rename all zip files to include total count (vol1of3, vol2of3, etc.)
    echo ""
    echo "Renaming zip files to include total volume count..."
    
    # Count total volumes created
    total_volumes=$(ls ${base_name}_vol*.zip 2>/dev/null | wc -l)
    
    if [ $total_volumes -gt 0 ]; then
        # Rename each zip file
        for i in $(seq 1 $total_volumes); do
            old_name="${base_name}_vol${i}.zip"
            new_name="${base_name}_vol${i}of${total_volumes}.zip"
            
            if [ -f "$old_name" ]; then
                mv "$old_name" "$new_name"
                echo "Renamed: $old_name → $new_name"
            fi
        done
    fi
    
    # Clean up temporary directory
    rm -rf "$temp_dir"
    
    echo ""
    echo "All subfolders have been zipped successfully!"
    echo "Created zip files: ${base_name}_vol*of${total_volumes}.zip"
}

# Main script starts here
echo "=== Zip File Creator ==="
echo ""
echo "Choose an option:"
echo "1. Create zip file(s) with volume splitting"
echo "2. Organize files into subfolders by size and zip each subfolder"
echo ""
echo -n "Enter your choice (1 or 2): "
read choice

case $choice in
    1)
        echo ""
        echo "=== Volume Splitting Mode ==="
        # Get the current directory name as default filename
        default_filename=$(basename "$(pwd)")
        echo "File name (default: $default_filename):"
        read filename
        filename=${filename:-$default_filename}

        echo "Input the package password (default: $filename):"
        read password
        password=${password:-$filename}
        echo "Input the split size in mb (leave empty for no splitting):"
        read volsize

        if [ -z "$volsize" ]; then
            # No splitting - create single zip file
            zip -r -P $password $filename.zip *
        else
            # Split the archive
            zip -r -P $password $filename+compress.zip *
            zip -r -s $volsize\m $filename.zip $filename+compress.zip
            rm -r $filename+compress.zip
        fi
        ;;
    2)
        echo ""
        echo "=== Subfolder Organization Mode ==="
        # Get the current directory name as default filename
        default_filename=$(basename "$(pwd)")
        echo "Base name for subfolders (default: $default_filename):"
        read filename
        filename=${filename:-$default_filename}

        echo "Input the package password (default: $filename):"
        read password
        password=${password:-$filename}
        echo "Input the maximum size per subfolder (default: 500m, examples: 100m, 1g, 500k):"
        read max_size
        max_size=${max_size:-500m}

        if [ -z "$max_size" ]; then
            echo "Error: Maximum size is required for this mode."
            exit 1
        fi

        # Convert size to bytes
        max_size_bytes=$(size_to_bytes "$max_size")
        
        if [ $max_size_bytes -eq 0 ]; then
            echo "Error: Invalid size format. Use formats like 100m, 1g, 500k"
            exit 1
        fi

        echo "Maximum size per subfolder: $(numfmt --to=iec $max_size_bytes)"
        echo ""
        
        organize_into_subfolders $max_size_bytes $filename $password
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose 1 or 2."
        exit 1
        ;;
esac

