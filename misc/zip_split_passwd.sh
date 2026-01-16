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

# Function to calculate total size of zip files
calculate_total_zip_size() {
    local pattern=$1
    local total_size=0

    for file in $pattern; do
        if [ -f "$file" ]; then
            local file_size=$(get_file_size "$file")
            total_size=$((total_size + file_size))
        fi
    done

    echo $total_size
}

# Function to generate a 16-character strong password
generate_password() {
    local chars="abcdefghijklmnopqrstuvwxyz0123456789"
    local password=""
    for i in {1..16}; do
        password+=${chars:$((RANDOM % ${#chars})):1}
    done
    echo "$password"
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
    
    while IFS= read -r -d '' file; do
        # Skip empty filenames
        [ -z "$file" ] && continue
        
        file_size=$(get_file_size "$file")
        
        # Ensure file_size is a valid number
        if ! [[ "$file_size" =~ ^[0-9]+$ ]]; then
            echo "Warning: Could not determine size for file $(basename "$file"), skipping..."
            continue
        fi
        
        if [ "$file_size" -gt "$max_size_bytes" ]; then
            echo "Warning: File $(basename "$file") ($(numfmt --to=iec $file_size)) exceeds maximum size limit ($(numfmt --to=iec $max_size_bytes))"
            echo "This file will be placed in its own archive."
        fi
        files+=("$file")
        file_sizes+=("$file_size")
    done < <(find . -maxdepth 1 -type f ! -name ".*" ! -name "$(basename "$0")" ! -name "$temp_dir" -print0 2>/dev/null)
    
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
            local current_bin_size=${bin_sizes[$bin_idx]:-0}
            local remaining_space=$((max_size_bytes - current_bin_size))
            if [ "$remaining_space" -ge "$file_size" ] && [ "$remaining_space" -lt "$best_remaining_space" ]; then
                best_bin=$bin_idx
                best_remaining_space=$remaining_space
            fi
        done
        
        # If no suitable bin found, create a new one
        if [ "$best_bin" -eq -1 ]; then
            best_bin=$num_bins
            bin_sizes[$best_bin]=0
            bin_files[$best_bin]=""
            num_bins=$((num_bins + 1))
        fi
        
        # Add file to the best bin
        local current_size=${bin_sizes[$best_bin]:-0}
        bin_sizes[$best_bin]=$((current_size + file_size))
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
        local bin_size=${bin_sizes[$bin_idx]:-0}
        local bin_num=$((bin_idx + 1))
        local utilization=$((bin_size * 100 / max_size_bytes))
        
        echo "Volume $bin_num: $(numfmt --to=iec $bin_size) (${utilization}% of max)"
        
        total_size=$((total_size + bin_size))
        if [ "$bin_size" -lt "$min_size" ]; then
            min_size=$bin_size
        fi
        if [ "$bin_size" -gt "$max_size" ]; then
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
    
    # Calculate total size of all created zip files
    total_zip_size=$(calculate_total_zip_size "${base_name}_vol*of${total_volumes}.zip")
    
    # Summary - repeat password and file names
    echo ""
    echo "  ${base_name}_${total_volumes}分卷打包 $(numfmt --to=iec $total_zip_size)"
    echo ""
    echo "=== SUMMARY ==="
    echo "Created files:"
    # List all actual volume files that were created
    for vol_file in ${base_name}_vol*of${total_volumes}.zip; do
        if [ -f "$vol_file" ]; then
            echo "  $vol_file"
        fi
    done
    echo "Total size: $(numfmt --to=iec $total_zip_size)"
    echo "[hide]"
    echo "Password: $password"
    echo "[/hide]"
    echo "================"
}

# Main script starts here
original_dir=$(pwd)
echo "=== Zip File Creator ==="
echo ""

# Ask about forum posts
read -p "Do you want to make forum posts? (y/n) " make_posts

# Always post to fid=2, without sharer
FORUM_ID=2
memo_suffix=''

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
        if [[ ! "$filename" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{2}- ]]; then
            filename="$(date +%y-%m-%d)-${filename}"
        fi

        echo "Input the package password (press y for: $filename, or press Enter to generate a strong 32-char password):"
        read password
        if [ -z "$password" ]; then
            read -p "Generate a strong 32-char password? (y/n) [y]: " generate
            generate=${generate:-y}
            if [ "$generate" = "y" ]; then
                password=$(generate_password)
            else
                password=$filename
            fi
        fi
        echo "Input the split size in mb (leave empty for no splitting):"
        read volsize

        if [ -z "$volsize" ]; then
            # No splitting - create single zip file
            zip -r -P $password $filename.zip *

            # Calculate total size
            total_size=$(calculate_total_zip_size "$filename.zip")

            # Build summary content
            summary_content=" ${filename} 打包 $(numfmt --to=iec $total_size)

=== SUMMARY ===
Created files:
  $filename.zip
Total size: $(numfmt --to=iec $total_size)
[hide]
Password: $password
[/hide]
==============="

            # Print summary
            echo "$summary_content"

                        if [ "$make_posts" = "y" ]; then
                mkdir -p ~/Nextcloud
                cp $filename.zip ~/Nextcloud/
                echo "Zip files copied to ~/Nextcloud/"
            fi

            # Forum posting
            if [ "$make_posts" = "y" ]; then
                post_title="${filename} 打包 $(numfmt --to=iec $total_size) ${memo_suffix}"
                post_content="$summary_content"

                # Escape single quotes for SQL
                post_title_escaped=$(echo "$post_title" | sed "s/'/\\'/g")
                post_content_escaped=$(echo "$post_content" | sed "s/'/\\'/g")

                current_time=$(date +%s)

                echo "Creating forum post for ${post_title}..."
                mysql -h linux24.tail22dc1.ts.net -u root -p'root_password' --ssl-mode=DISABLED --default-character-set=utf8mb4 ultrax <<EOF
START TRANSACTION;

# Create a new thread
INSERT INTO pre_forum_thread
(fid, author, authorid, subject, dateline, lastpost, lastposter, views, replies, displayorder, readperm)
VALUES
($FORUM_ID, '苦艾酒', 1, '${post_title_escaped}', $current_time, $current_time, '苦艾酒', 0, 0, 0, 10);

SET @tid = LAST_INSERT_ID();

# Get a new PID from the tableid table
INSERT INTO pre_forum_post_tableid VALUES (NULL);
SET @next_pid = LAST_INSERT_ID();

# Create the post with the generated PID
INSERT INTO pre_forum_post
(pid, tid, fid, first, author, authorid, subject, dateline, message, useip, port,
premsg, invisible, anonymous, usesig, htmlon, bbcodeoff, smileyoff, parseurloff, attachment, status, position)
VALUES
(@next_pid, @tid, $FORUM_ID, 1, '苦艾酒', 1, '${post_title_escaped}', $current_time, '${post_content_escaped}', '127.0.0.1', 0,
'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

COMMIT;
EOF
                echo "Forum post created!"
            fi
        else
            # Split the archive
            zip -r -P $password $filename+compress.zip *
            zip -r -s $volsize\m $filename.zip $filename+compress.zip
            rm -r $filename+compress.zip

            # Calculate total size of all volume files
            total_size=$(calculate_total_zip_size "$filename.z*")

            # Build summary content
            summary_content=" ${filename} 打包 $(numfmt --to=iec $total_size)

=== SUMMARY ===
Split size: ${volsize}mb
Created files:
$(for vol_file in $filename.z*; do
    if [ -f "$vol_file" ]; then
        echo "  $vol_file"
    fi
done)
Total size: $(numfmt --to=iec $total_size)
[hide]
Password: $password
[/hide]
==============="

            # Print summary
            echo "$summary_content"

            if [ "$make_posts" = "y" ]; then
                mkdir -p ~/Nextcloud
                cp $filename.z* ~/Nextcloud/
                echo "Zip files copied to ~/Nextcloud/"
            fi

            # Forum posting
            if [ "$make_posts" = "y" ]; then
                post_title="${filename} 打包 $(numfmt --to=iec $total_size) ${memo_suffix}"
                post_content="$summary_content"

                # Escape single quotes for SQL
                post_title_escaped=$(echo "$post_title" | sed "s/'/\\'/g")
                post_content_escaped=$(echo "$post_content" | sed "s/'/\\'/g")

                current_time=$(date +%s)

                echo "Creating forum post for ${post_title}..."
                mysql -h linux24.tail22dc1.ts.net -u root -p'root_password' --ssl-mode=DISABLED --default-character-set=utf8mb4 ultrax <<EOF
START TRANSACTION;

# Create a new thread
INSERT INTO pre_forum_thread
(fid, author, authorid, subject, dateline, lastpost, lastposter, views, replies, displayorder, readperm)
VALUES
($FORUM_ID, '苦艾酒', 1, '${post_title_escaped}', $current_time, $current_time, '苦艾酒', 0, 0, 0, 10);

SET @tid = LAST_INSERT_ID();

# Get a new PID from the tableid table
INSERT INTO pre_forum_post_tableid VALUES (NULL);
SET @next_pid = LAST_INSERT_ID();

# Create the post with the generated PID
INSERT INTO pre_forum_post
(pid, tid, fid, first, author, authorid, subject, dateline, message, useip, port,
premsg, invisible, anonymous, usesig, htmlon, bbcodeoff, smileyoff, parseurloff, attachment, status, position)
VALUES
(@next_pid, @tid, $FORUM_ID, 1, '苦艾酒', 1, '${post_title_escaped}', $current_time, '${post_content_escaped}', '127.0.0.1', 0,
'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

COMMIT;
EOF
                echo "Forum post created!"
             fi
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
        if [[ ! "$filename" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{2}- ]]; then
            filename="$(date +%y-%m-%d)-${filename}"
        fi

        echo "Input the package password (default: $filename, or press Enter to generate a strong 32-char password):"
        read password
        if [ -z "$password" ]; then
            read -p "Generate a strong 32-char password? (y/n) [y]: " generate
            generate=${generate:-y}
            if [ "$generate" = "y" ]; then
                password=$(generate_password)
            else
                password=$filename
            fi
        fi
        echo "Input the maximum size per subfolder (default: 500m, examples: 100m, 1g, 500k):"
        read max_size
        max_size=${max_size:-500m}

        if [ -z "$max_size" ]; then
            echo "Error: Maximum size is required for this mode."
            exit 1
        fi

        # Convert size to bytes
        max_size_bytes=$(size_to_bytes "$max_size")
        
        if [ "$max_size_bytes" -eq 0 ]; then
            echo "Error: Invalid size format. Use formats like 100m, 1g, 500k"
            exit 1
        fi

        echo "Maximum size per subfolder: $(numfmt --to=iec $max_size_bytes)"
        echo ""

        organize_into_subfolders $max_size_bytes $filename $password

        # Calculate total volumes and size for posting
        total_volumes=$(ls ${filename}_vol*of*.zip 2>/dev/null | wc -l | tr -d ' ')
        if [ $total_volumes -gt 0 ]; then
            total_zip_size=$(calculate_total_zip_size "${filename}_vol*of${total_volumes}.zip")

            # Forum posting
            if [ "$make_posts" = "y" ]; then
                post_title="${filename}_${total_volumes}分卷打包 $(numfmt --to=iec $total_zip_size) ${memo_suffix}"
                post_content=" ${filename}_${total_volumes}分卷打包 $(numfmt --to=iec $total_zip_size)

=== SUMMARY ===
Created files:
$(for vol_file in ${filename}_vol*of${total_volumes}.zip; do
    if [ -f "$vol_file" ]; then
        echo "  $vol_file"
    fi
done)
Total size: $(numfmt --to=iec $total_zip_size)
[hide]
Password: $password
[/hide]
================"

                # Escape single quotes for SQL
                post_title_escaped=$(echo "$post_title" | sed "s/'/\\'/g")
                post_content_escaped=$(echo "$post_content" | sed "s/'/\\'/g")

                current_time=$(date +%s)

                echo "Creating forum post for ${post_title}..."
                mysql -h linux24.tail22dc1.ts.net -u root -p'root_password' --ssl-mode=DISABLED --default-character-set=utf8mb4 ultrax <<EOF
START TRANSACTION;

# Create a new thread
INSERT INTO pre_forum_thread
(fid, author, authorid, subject, dateline, lastpost, lastposter, views, replies, displayorder, readperm)
VALUES
($FORUM_ID, '苦艾酒', 1, '${post_title_escaped}', $current_time, $current_time, '苦艾酒', 0, 0, 0, 10);

SET @tid = LAST_INSERT_ID();

# Get a new PID from the tableid table
INSERT INTO pre_forum_post_tableid VALUES (NULL);
SET @next_pid = LAST_INSERT_ID();

# Create the post with the generated PID
INSERT INTO pre_forum_post
(pid, tid, fid, first, author, authorid, subject, dateline, message, useip, port,
premsg, invisible, anonymous, usesig, htmlon, bbcodeoff, smileyoff, parseurloff, attachment, status, position)
VALUES
(@next_pid, @tid, $FORUM_ID, 1, '苦艾酒', 1, '${post_title_escaped}', $current_time, '${post_content_escaped}', '127.0.0.1', 0,
'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

COMMIT;
EOF
                echo "Forum post created!"
            fi
        fi

        if [ "$make_posts" = "y" ]; then
            mkdir -p ~/Nextcloud
            # Calculate total volumes
            total_volumes=$(ls ${filename}_vol*of*.zip 2>/dev/null | wc -l | tr -d ' ')
            if [ $total_volumes -gt 0 ]; then
                cp ${filename}_vol*of${total_volumes}.zip ~/Nextcloud/
            fi
            echo "Zip files copied to ~/Nextcloud/"
        fi
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose 1 or 2."
        exit 1
        ;;
esac

if [ "$make_posts" = "y" ] && [ "$filename" != "$(basename "$original_dir")" ]; then
    cd ..
    mv "$original_dir" "$filename"
fi

