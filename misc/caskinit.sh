#!/bin/sh

#brew tap caskroom/cask
brew tap homebrew/cask-versions

# Browsers
brew install --cask --force google-chrome
brew install --cask --force tor-browser
brew install --cask --force zeronet
brew install --cask --force firestorm

# password manager
brew install --cask --force bitwarden

# Development
# brew install --cask --force  visual-studio-code
brew install --cask --force iterm2
brew install --cask --force gitkraken
brew install --cask --force intellij-idea

# install intellij-idea command line launcher for macos

idea_launcher="/usr/local/bin/idea"

# Check if the file /usr/local/bin/idea already exists
if [ -f "$idea_launcher" ]; then
	rm "$idea_launcher"
	echo "Existing IntelliJ IDEA command line launcher removed."
fi

# Create the file /usr/local/bin/idea
echo '#!/bin/sh' >"$idea_launcher"
echo 'open -na "IntelliJ IDEA.app" --args "$@"' >>"$idea_launcher"

# Make the script executable
chmod +x "$idea_launcher"

# echo "IntelliJ IDEA command line launcher installed successfully."

# brew install --cask --force java
brew install --cask --force temurin # this is java openjdk
brew install --cask --force sublime-text
brew install --cask --force wireshark

# Communication
# brew install --cask --force  whatsapp
brew install --cask --force franz
brew install --cask --force slack
brew install --cask --force qq
brew install --cask --force discord

# Cloud
# brew install --cask --force  dropbox
brew isntall --cask --force free-download-manager
brew install --cask --force shadowsocksx-ng
brew install --cask --force tailscale

# Productivity
# brew install --cask --force  alfred
brew install --cask --force docker
brew install --cask --force grammarly
brew install --cask --force rescuetime
brew install --cask --force google-japanese-ime
#brew install --cask --force  sogouinput #this is not available anymore
brew install --cask --force microsoft-office
brew install --cask --force forklift
brew install --cask --force microsoft-remote-desktop

# Media
brew install --cask --force blender
# brew install --cask --force soundflower
brew install --cask --force adobe-creative-cloud
brew install --cask --force handbrake
brew install --cask --force spotify

# Mac OS Enhancements
brew install --cask --force the-unarchiver
brew tap buo/cask-upgrade
brew install --cask --force zenmap
brew install --cask --force carbon-copy-cloner
brew install --cask --force karabiner-elements
brew install --cask --force wifispoof

# Other
brew install --cask --force font-hack-nerd-font

# Install Mac App Store apps
# add Magnet install


# disable tencent permissions
./misc/tecentpermission.sh
