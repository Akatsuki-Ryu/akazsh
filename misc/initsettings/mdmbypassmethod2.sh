#!/bin/bash

# read from user input if download from the internet or run the local code
echo "Do you want to download the script from the internet and run, press N to run local script (y/n)"
read -r download
if [ "$download" = "y" ]; then
    echo "Downloading the script from the internet"
    curl https://raw.githubusercontent.com/skipmdm-phoenixbot/skipmdm.com/main/Autobypass-mdm.sh -o test.sh && chmod +x ./test.sh && ./test.sh
    exit 0
else
    echo "Running the local script"
    ./test.sh
fi

