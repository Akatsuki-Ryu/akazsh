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

# Function to organize files into subfolders by size using intelligent bin-packing
organize_into_subfolders() {
    local max_size_bytes=$1
    local base_name=$2
    local password=$3
    
    echo "Organizing files into subfolders using intelligent distribution..."
    
    # Create a temporary directory to work in
    temp_dir="temp_organize_$$"
    mkdir -p "$temp_dir"
    
    # Get all files with their sizes
    declare -a files
    declare -a file_sizes
    declare -A file_size_map
    
    while IFS= read -r -d '' file; do
        file_size=$(get_file_size "$file")
        if [ $file_size -gt $max_size_bytes ]; then
            echo "Warning: File $(basename "$file") ($(numfmt --to=iec $file_size)) exceeds maximum size limit ($(numfmt --to=iec $max_size_bytes))"
            echo "This file will be placed in its own archive."
        fi
        files+=("$file")
        file_sizes+=("$file_size")
        file_size_map["$file"]=$file_size
    done < <(find . -maxdepth 1 -type f ! -name ".*" ! -name "$(basename "$0")" ! -name "$temp_dir" -print0)
    
    if [ ${#files[@]} -eq 0 ]; then
        echo "No files found to organize."
        rmdir "$temp_dir"
        return 1
    fi
    
    # Sort files by size (largest first) for better bin-packing
    declare -a sorted_files
    declare -a sorted_sizes
    
    # Create array of indices and sort by file size (descending)
    declare -a indices
    for i in "${!files[@]}"; do
        indices+=("$i")
    done
    
    # Simple bubble sort by file size (descending)
    local n=${#indices[@]}
    for ((i = 0; i < n-1; i++)); do
        for ((j = 0; j < n-i-1; j++)); do
            local idx1=${indices[j]}
            local idx2=${indices[j+1]}
            if [ ${file_sizes[idx1]} -lt ${file_sizes[idx2]} ]; then
                # Swap indices
                local temp=${indices[j]}
                indices[j]=${indices[j+1]}
                indices[j+1]=$temp
            fi
        done
    done
    
    # Create sorted arrays
    for idx in "${indices[@]}"; do
        sorted_files+=("${files[idx]}")
        sorted_sizes+=("${file_sizes[idx]}")
    done
    
    # Initialize bins (folders)
    declare -a bin_sizes
    declare -a bin_files
    local num_bins=0
    
    echo "Distributing files using best-fit-decreasing algorithm..."
    echo "Total files to distribute: ${#sorted_files[@]}"
    
    # Distribute files using best-fit-decreasing algorithm
    for i in "${!sorted_files[@]}"; do
        local file="${sorted_files[i]}"
        local file_size="${sorted_sizes[i]}"
        local file_name=$(basename "$file")
        
        # Find the best bin (smallest remaining space that can fit this file)
        local best_bin=-1
        local best_remaining_space=$max_size_bytes
        
        for bin_idx in $(seq 0 $((num_bins-1))); do
            local remaining_space=$((max_size_bytes - bin_sizes[bin_idx]))
            if [ $remaining_space -ge $file_size ] && [ $remaining_space -lt $best_remaining_space ]; then
                best_bin=$bin_idx
                best_remaining_space=$remaining_space
            fi
        done
        
        # If no suitable bin found, create a new one
        if [ $best_bin -eq -1 ]; then
            best_bin=$num_bins
            bin_sizes[$best_bin]=0
            bin_files[$best_bin]=""
            num_bins=$((num_bins + 1))
        fi
        
        # Add file to the best bin
        bin_sizes[$best_bin]=$((bin_sizes[best_bin] + file_size))
        if [ -z "${bin_files[$best_bin]}" ]; then
            bin_files[$best_bin]="$file"
        else
            bin_files[$best_bin]="${bin_files[$best_bin]}|$file"
        fi
        
        local bin_num=$((best_bin + 1))
        echo "Added $file_name ($(numfmt --to=iec $file_size)) to vol$bin_num - Total: $(numfmt --to=iec ${bin_sizes[$best_bin]})"
    done
    
    echo ""
    echo "=== Distribution Summary ==="
    local total_size=0
    local min_size=$max_size_bytes
    local max_size=0
    
    for bin_idx in $(seq 0 $((num_bins-1))); do
        local bin_size=${bin_sizes[$bin_idx]}
        local bin_num=$((bin_idx + 1))
        local utilization=$((bin_size * 100 / max_size_bytes))
        
        echo "Volume $bin_num: $(numfmt --to=iec $bin_size) (${utilization}% of max)"
        
        total_size=$((total_size + bin_size))
        if [ $bin_size -lt $min_size ]; then
            min_size=$bin_size
        fi
        if [ $bin_size -gt $max_size ]; then
            max_size=$bin_size
        fi
    done
    
    local avg_size=$((total_size / num_bins))
    local size_variance=$((max_size - min_size))
    
    echo ""
    echo "Statistics:"
    echo "  Total size: $(numfmt --to=iec $total_size)"
    echo "  Average size per volume: $(numfmt --to=iec $avg_size)"
    echo "  Size variance: $(numfmt --to=iec $size_variance)"
    echo "  Efficiency: $((total_size * 100 / (num_bins * max_size_bytes)))%"
    echo ""
    
    # Create the actual folders and copy files
    echo "Creating subfolders and copying files..."
    for bin_idx in $(seq 0 $((num_bins-1))); do
        local bin_num=$((bin_idx + 1))
        local folder_name="${base_name}_vol${bin_num}"
        mkdir -p "$temp_dir/$folder_name"
        
        # Split the file list and copy each file
        IFS='|' read -ra file_array <<< "${bin_files[$bin_idx]}"
        for file in "${file_array[@]}"; do
            if [ -n "$file" ]; then
                if cp "$file" "$temp_dir/$folder_name/"; then
                    echo "Copied $(basename "$file") to $folder_name"
                else
                    echo "Error: Failed to copy $(basename "$file")"
                fi
            fi
        done
    done
    
    echo ""
    echo "Created $num_bins optimally distributed subfolders."
    
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
    total_volumes=$(ls ${base_name}_vol*.zip 2>/dev/null | wc -l | tr -d ' ')
    
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
    
    # Summary - repeat password and file names
    echo ""
    echo "=== SUMMARY ==="
    echo "Created files:"
    for i in $(seq 1 $total_volumes); do
        echo "  ${base_name}_vol${i}of${total_volumes}.zip"
    done
    echo "Password: $password"
    echo "================"
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
            
            # Summary for single file
            echo ""
            echo "=== SUMMARY ==="
            echo "Password: $password"
            echo "Created file: $filename.zip"
            echo "================"
        else
            # Split the archive
            zip -r -P $password $filename+compress.zip *
            zip -r -s $volsize\m $filename.zip $filename+compress.zip
            rm -r $filename+compress.zip
            
            # Summary for split files
            echo ""
            echo "=== SUMMARY ==="
            echo "Password: $password"
            echo "Split size: ${volsize}mb"
            echo "Created files: $filename.z?? (volume files)"
            echo "================"
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

