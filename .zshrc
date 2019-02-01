# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)


source $ZSH/oh-my-zsh.sh

# User configuration

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
 source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
 source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'


#config for the libmobiledevice log
export DYLD_LIBRARY_PATH=/Users/akatsuki/libmobiledevice/:$DYLD_LIBRARY_PATH
PATH=${PATH}:/Users/akatsuki/libmobiledevice/

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

alias zshconfig="subl ~/.zshrc"



#######################################################################brew related 

alias bup="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; say data update mission complete"
alias bupfull="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup; say full data update mission complete"
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
alias bkuf="brew cask uninstall --force"
alias bkl="brew cask list"
alias bdelall="brew remove --force $(brew list) --ignore-dependencies  "
alias bkdelall="brew cask remove --force $(brew cask list) "


#########################system level
alias rmr="sudo rm -r"
alias zipsp="zip -r -s 150m zip.zip "
alias p="pwd"
alias zippwd="zip -e zip.zip"
alias tmn="tmux new -s phone"
alias tma="tmux attach -t phone"
alias tmu="tmux kill-session -t phone"
alias d="docker"
alias mc='LANG=en_EN.UTF-8 mc'
alias h='htop'
alias du='ncdu -2 -x --exclude .git'
alias cat='bat'
alias ping='prettyping'
alias mksnapshot='tmutil snapshot'
alias lssnapshot='tmutil listlocalsnapshots /Volumes'

#################################applications and linux
alias n="npm"
alias ni="npm install"
export PATH=/usr/local/bin:$PATH
alias iftop="sudo /usr/local/Cellar/iftop/1.0pre4/sbin/./iftop"

alias api="sudo apt-get install"
alias apup="sudo apt-get update"
alias apu="sudo apt-get uninstall"



################################################### local navi
alias do="cd ~/Downloads"
alias dd="cd ~/Desktop"
alias dl="cd ~/Downloads"


#################################################### network navi
alias sshyc="ssh yc@121.40.61.76"
alias sshqa="ssh akatsukiliu@10.5.115.126"
##alias sshprod="ssh akatsukiliu@80.242.17.226"
##alias sshqaold="ssh akatsukiliu@80.242.18.243"
##alias sshdev="ssh akatsukiliu@10.211.55.6"
##alias sshubb="ssh akatsuki@10.211.55.11"
##alias sshixo="ssh liuakat@10.254.20.42"
alias sshhome="ssh -p 10022 akatsuki@62.78.181.155"
alias sshdigi="ssh -p 20022 akatsuki@62.78.181.155"
alias sshavi="ssh -p 30022 akatsuki@62.78.181.155"
##alias android="/Users/akatsuki/Library/Android/sdk/tools/android"
alias sshxiaomi="ssh root@82.130.43.175"


################################### system navi

alias sshaaltohtml="ssh -L 8080:wwwproxy.hut.fi:80 liux2@kosh.aalto.fi"
alias sshaaltoall="ssh -D8080 liux2@kosh.aalto.fi"
alias sshvpn="ssh -D8080 -p10022 akatsuki@62.78.181.155"
export PATH="/usr/local/sbin:$PATH"
alias ise="ionic serve"
alias ira="ionic cordova run android"
alias irar="ionic cordova run android --livereload"
alias killremote="killall "Remote Desktop""

##alias creatersa="ssh-keygen -b 1024 -t rsa -f id_rsa -P """

export PATH=$PATH:/Users/akatsuki/Library/Android/sdk/platform-tools
export PATH=$PATH:/Library/Developer/CommandLineTools/usr/bin/codesign_allocate

# Recursively delete `.DS_Store` files
# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete;sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent';say data cleaning up complete"


# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'




#########################################################################################################################################33


#new line
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

#right new line
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(history context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs  load ram swap battery time)

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# POWERLEVEL9K_COLOR_SCHEME='dark' #default is black

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B2'

#POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$''
#POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$''
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(icons_test)

#POWERLEVEL9K_TIME_FOREGROUND='red'
#POWERLEVEL9K_TIME_BACKGROUND='blue'

POWERLEVEL9K_VCS_FOREGROUND='021' # Dark blues

# Advanced `vcs` color customization
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'

# Segment in black and white
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="white"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="black"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="white"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="white"
# Colorize only the visual identifier
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"

POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE="true"
POWERLEVEL9K_BATTERY_STAGES=($'\u2581 ' $'\u2582 ' $'\u2583 ' $'\u2584 ' $'\u2585 ' $'\u2586 ' $'\u2587 ' $'\u2588 ')
 POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(red2 orangered2 darkorange orange2 gold2 yellow2 yellow3 155 chartreuse2 chartreuse3 green2)
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND="darkreda"
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND="green4"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD="2"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION="3"

POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="grey"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="white"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="yellow"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="white"
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="red"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="white"




