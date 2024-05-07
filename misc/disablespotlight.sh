#this will disable the spotlight indexing to prevent mdworker shared kernel panic situation

sudo mdutil -a -i off

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

# to enable it back
# sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
# sudo mdutil -a -i on
