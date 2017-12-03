# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tjkirch"

#config for the libmobiledevice log
export DYLD_LIBRARY_PATH=/Users/akatsuki/libmobiledevice/:$DYLD_LIBRARY_PATH
PATH=${PATH}:/Users/akatsuki/libmobiledevice/


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"



#######################################################################brew related 

alias bup="brew update && b upgrade --all"
alias b="brew"
alias bi="brew install"
alias bu="brew uninstall"
alias bs="brew search"
alias bl="brew list"
alias bk="brew cask"
alias bks="brew cask search"
alias bki="brew cask install"
alias bkif="brew cask install --force"
alias bku="brew cask uninstall"
alias bkl="brew cask list"



#########################system level
alias rmr="sudo rm -r"
alias zipsp="zip -r -s 15m zip.zip "
alias d="pwd"
alias spotrip="spotify-ripper -u akatsuki_ryu -p liuxiaofeng "
alias tmn="tmux new -s phone"
alias tma="tmux attach -t phone"
alias tmu="tmux kill-session -t phone"


#################################applications and linux
alias n="npm"
alias ni="npm install"
export PATH=/usr/local/bin:$PATH
alias iftop="sudo /usr/local/Cellar/iftop/1.0pre4/sbin/./iftop"

alias api="sudo apt-get install"
alias apup="sudo apt-get update"
alias apu="sudo apt-get uninstall"


####################################################
alias sshyc="ssh yc@121.40.61.76"
alias sshqa="ssh akatsukiliu@10.5.115.126"
##alias sshprod="ssh akatsukiliu@80.242.17.226"
##alias sshqaold="ssh akatsukiliu@80.242.18.243"
##alias sshdev="ssh akatsukiliu@10.211.55.6"
##alias sshubb="ssh akatsuki@10.211.55.11"
##alias sshixo="ssh liuakat@10.254.20.42"
alias sshhome="ssh akatsuki@82.130.43.170"
alias sshbel="ssh -p 50022 akatsuki@82.130.43.170"
##alias android="/Users/akatsuki/Library/Android/sdk/tools/android"
alias sshxiaomi="ssh root@82.130.43.170"


###################################

alias topp="top -o cpu"
alias sshaaltohtml="ssh -L 8080:wwwproxy.hut.fi:80 liux2@kosh.aalto.fi"
alias sshaaltoall="ssh -D8080 liux2@kosh.aalto.fi"
export PATH="/usr/local/sbin:$PATH"
alias ise="ionic serve"
alias ira="ionic cordova run android"
alias killremote="killall "Remote Desktop""


alias ariad="aria2c --conf-path="/Users/akatsuki/.aria2/aria2.conf" -D"

