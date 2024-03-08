#this will disable the spotlight indexing to prevent mdworker shared kernel panic situation

sudo mdutil -a -i off

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

