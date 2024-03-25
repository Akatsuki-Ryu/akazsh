#!/usr/bin/env bash
# from https://github.com/mathiasbynens/dotfiles/blob/master/brew.sh

# Install command-line tools using Homebrew.

which -s brew
if [[ $? != 0 ]]; then
	yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Homebrew already installed ..."
fi

export PATH="/opt/homebrew/sbin:$PATH"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install a modern version of Bash.
# brew install bash
# brew install bash-completion2

# Switch to using brew-installed bash as default shell
#if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
#  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
#  chsh -s "${BREW_PREFIX}/bin/bash";
#fi;

# Install zsh
brew install zsh
brew install tree
# brew install getantibody/tap/antibody
brew install tmux
brew install mc

# Check if zsh is in list of accepted shells
if grep -Fxq "/usr/local/bin/zsh" /etc/shells >/dev/null 2>&1; then
	echo "zsh is already in the list of accepted shells ..."
else
	# If not found
	echo "Adding zsh to list of accepted shells ..."
	sudo sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
fi

# Check if zsh is default shell
if echo "$SHELL" | grep /bin/bash >/dev/null 2>&1; then
	echo "Setting zsh as default shell ..."
	chsh -s /usr/local/bin/zsh
else
	echo "zsh is already the default shell ..."
fi

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install ack #better grep
brew install openssh
# brew install screen
brew install php
brew install gmp
brew install bat  #better cat
brew install htop #better top
brew install btop #even better top
brew install iftop
brew install ncdu
brew install duf #better df
brew install prettyping
brew install eza #better ls
brew install rg  # better grep
brew install fzf

# navigation akabox
# brew install autojump
brew install zoxide #replacing the autojump for now
#brew install zsh-autosuggestions #use ohmyzsh to install , so we dont install them from here
#brew install zsh-completions
#brew install zsh-syntax-highlighting

#fun stuff akabox
brew install cmatrix #redpill
brew install sl      #a train
brew install genact  #what are you doing
brew install hr      #horizental line
brew install thefuck

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# CTF akabox
brew install bettercap
brew install crunch #generate dictionary
brew install hashcat
brew install libpcap
brew install mkcert
brew install nikto
brew install reaver
brew install tcpdump

# Git
brew install git
brew install git-flow
brew install git-lfs
# brew install cdiffs
brew install hub
brew install lazygit
brew install gh

# Install other useful binaries.
#brew install exiv2
#brew install gs
# brew install imagemagick --with-webp
#brew install lua
brew install lynx #text based web browswer
brew install p7zip
brew install pigz
brew install pv # visual pipline progress bar
brew install rename
brew install rlwrap #adding visual line wrap
brew install ssh-copy-id
brew install vbindiff
brew install zopfli # this is a zlib compressor

#application level stuff
brew install baidupcs-go
brew install docker
brew install fd
brew install packer
brew install sshfs
brew tap v2ray/v2ray
brew install v2ray-core
brew install vagrant-completion
brew install youtube-dl

# media related
brew install ffmpeg
brew install flac
brew install lame
brew install libogg

# Development
brew install python@3.11
brew install miniconda
brew install ruby
brew install yarn
brew install node
brew install nvm
brew install cmake
brew install go
brew install gradle
brew install rust
brew install rustup-init

# Highlighting
brew install source-highlight
brew install diff-so-fancy

# font related (temp)
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font

# paackage manager
brew tap buo/cask-upgrade   #this is the b cu
brew tap beeftornado/rmtree #remove the whole dependency

# Other
brew install mas
brew install neovim
# brew install gdrive
brew install micro #terminal text editor

#docker manager
brew tap moncho/dry
brew install dry

# Remove outdated versions from the cellar.
brew cleanup
