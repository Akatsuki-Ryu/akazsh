#!/bin/bash

# Get the current directory name as default filename
default_filename=$(basename "$(pwd)")
echo "File name (default: $default_filename):"
read filename
filename=${filename:-$default_filename}

echo "Input the package password:"
read password
echo "Input the split size in mb:"
read volsize
zip -r -P $password $filename+compress.zip *

zip -r -s $volsize\m $filename.zip $filename+compress.zip
rm -r $filename+compress.zip

