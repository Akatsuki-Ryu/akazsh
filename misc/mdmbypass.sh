#!/bin/bash
## check if mac is having the system integrity protection enabled

# Check if System Integrity Protection is enabled
output=$(csrutil status)

if [[ $output == *"enabled"* ]]; then
  echo "System Integrity Protection is enabled. need to disable it first"
  exit 1
else
  echo "System Integrity Protection is not enabled. continue."
fi

# set the enrollment to false
echo "setting enrollment to false"
# Define the file path
plist_file="/System/Library/LaunchDaemons/com.apple.ManagedClient.enroll.plist"

# Use sudo to get necessary permissions and sed to replace the line
sudo sed -i '' 's|<key>com.apple.ManagedClient.enroll</key>\
        <true/>|<key>com.apple.ManagedClient.enroll</key>\
        <false/>|' "$plist_file"

# remove the enrollment record
echo  "removing enrollment record"
sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord

sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound

sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled

sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
