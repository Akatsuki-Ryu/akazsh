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
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
plugins=(git docker-compose)



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

################path for golang
export GOPATH=$HOME/go
alias zshconfig="subl ~/.zshrc"


# Aliases source file
source $HOME/akazsh/.aliases

# android configure source file
source $HOME/akazsh/androidconf


#######################################################################brew related

alias bup="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; brew cask update; brew cask upgrade; say data update mission complete"
alias bupfull="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; brew cask update; brew cask upgrade; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup; say full data update mission complete"
alias bcu="b cu -af"
alias b="brew"
alias bi="brew install"
alias bu="brew uninstall"
alias bs="brew search"
alias bl="brew list"
alias btree="brew deps --tree --installed"
alias bk="brew cask"
alias bks="brew cask search"
alias bki="brew cask install"
alias bkif="brew cask install --force"
alias bku="brew cask uninstall"
alias bkuf="brew cask uninstall --force"
alias bkl="brew cask list"
alias brmall="brew list -1 | xargs brew rm --force"
alias bkrmall="brew cask list -1 | xargs brew cask rm --force"
alias bltree="brew deps --tree --installed"


#########################system level
alias rmr="sudo rm -r"
alias cpr="sudo cp -r"
alias mvr="sudo mv -r"
alias zipsp150="zip -r -s 150m zip.zip "
alias zipsp10="zip -r -s 10m zip.zip "
alias zippwdsp50="~/akazsh/misc/zip_split_passwd50.sh"
alias zippwdsp150="~/akazsh/misc/zip_split_passwd150.sh"
alias p="pwd"
alias k="ls -atlr"
alias o="open ."
alias x="exit"
alias zippwd="zip -e zip.zip"
alias tmn="tmux new -s akaboxsession"
alias tma="tmux attach -t akaboxsession"
alias tmu="tmux kill-session -t akaboxsession"
alias mc='LANG=en_EN.UTF-8 mc'
alias m='micro'
alias s='subl'
alias h='htop'
alias a='glances'
alias hs='sudo htop'
alias du='ncdu -2 -x --exclude .git'
alias df='df -H'
alias cat='bat'
alias ping='prettyping'
alias mksnapshot='tmutil snapshot'
alias lssnapshot='tmutil listlocalsnapshots /Volumes'
alias t='tig --all'
alias gaac='git add --all; git commit -m'
alias gsiu='git submodule init && git submodule update'

alias kra='open -na "GitKraken" --args -p $(pwd)'


###############################docker
alias d="docker"
alias dps="docker ps -al"
alias di="docker image"
# alias dirmall="docker rmi -f $(docker images -a -q) || $(docker images -a -q)"
alias dirmall="~/akazsh/misc/dockercommands/dirmall.sh"
# alias direset="docker system prune -f"
alias drmall="~/akazsh/misc/dockercommands/drmall.sh"
alias dreset="~/akazsh/misc/dockercommands/dreset.sh"



#################################applications and linux
alias n="npm"
alias ni="npm install"
alias ncl="find . -name "node_modules" -type d -prune -exec rm -rf '{}' +"
alias ns="npm start"
export PATH=/usr/local/bin:$PATH
alias iftop="sudo /usr/local/Cellar/iftop/1.0pre4/sbin/./iftop"

alias ai="sudo apt-get install"
alias aup="sudo apt-get update; sudo apt-get upgrade"
alias au="sudo apt-get uninstall"
alias aupfull="sudo apt-get dist-upgrade"



################################################### local navi
alias do="cd ~/Documents"
alias dd="cd ~/Desktop"
alias dl="cd ~/Downloads"


#################################################### network navi
##alias sshyc="ssh yc@121.40.61.76"
##alias sshqa="ssh akatsukiliu@10.5.115.126"
##alias sshprod="ssh akatsukiliu@80.242.17.226"
##alias sshqaold="ssh akatsukiliu@80.242.18.243"
##alias sshdev="ssh akatsukiliu@10.211.55.6"
##alias sshubb="ssh akatsuki@10.211.55.11"
##alias sshixo="ssh liuakat@10.254.20.42"
alias sshhome="ssh -p 10022 akatsuki@89.27.83.105"
alias sshdigi="ssh -p 20022 akatsuki@89.27.83.105"
alias sshavi="ssh -p 30022 akatsuki@89.27.83.105"
alias sshmini="ssh dghelsinki@192.168.50.79"
alias sshminiakabox="ssh dghelsinki@192.168.50.80"
alias sshprez="ssh akatsuki@192.168.50.84"
alias sshaws="ssh -i "akaboxcentos.pem.txt" centos@ec2-13-48-25-117.eu-north-1.compute.amazonaws.com"
alias sshtunnel="ssh -i "akaboxtunnel.pem.txt" ubuntu@ec2-13-48-149-61.eu-north-1.compute.amazonaws.com"
alias sshtokyo="ssh -i "tokyokeypair.pem" ubuntu@ec2-13-113-175-125.ap-northeast-1.compute.amazonaws.com"
alias sshhongkong="ssh -i "akaboxhongkong.pem" ubuntu@ec2-18-162-124-93.ap-east-1.compute.amazonaws.com"


##alias android="/Users/akatsuki/Library/Android/sdk/tools/android"
alias sshmountavi="sshfs -p 30022 akatsuki@62.78.181.155:/Users/akatsuki /Users/akatsuki/mountavi"
alias syncfromavi="rsync -av --rsh='ssh -p30022' akatsuki@62.78.181.155:~/0transfer /Users/akatsuki/"
alias synctoavi="rsync -av /Users/akatsuki/0transfer  --rsh='ssh -p30022' akatsuki@62.78.181.155:~/ "

######################################################remote mount
alias sshxiaomi="ssh root@192.168.31.1"


################################### system navi

alias sshaaltohtml="ssh -L 8080:wwwproxy.hut.fi:80 liux2@kosh.aalto.fi"
alias sshaaltoall="ssh -D8080 liux2@kosh.aalto.fi"
alias sshvpn="networksetup -switchtolocation tunnel; ssh -D8080 -p10022 akatsuki@62.78.181.155"
alias sshvpnixo="ssh -D8080 -p22 liuakat@10.100.5.11"
alias shadowvpnserver="/Users/akatsuki/akazsh/shadowsocks/shadowsocks-server"
alias v2rayvpnclient=" networksetup -switchtolocation tunnel; v2ray -config=/Users/akatsuki/akazsh/v2raybin/configclient.json;"
alias v2rayvpnserver="v2ray -config=/Users/akatsuki/akazsh/v2raybin/configserver.json"
alias netswauto="networksetup -switchtolocation automatic"
alias netswtunnel="networksetup -switchtolocation tunnel"

export PATH="/usr/local/sbin:$PATH"
alias ise="ionic serve"
alias ira="ionic cordova run android"
alias irar="ionic cordova run android --livereload"
alias ws8000="ws -p 8000 --log.format logstalgia"
alias ws3000="ws -p 3000 --log.format logstalgia"
alias wspwd3000z="ws -p 3000 --log.format logstalgia --auth.user z --auth.pass z "
alias wspwd3000pass="ws -p 3000 --log.format logstalgia --auth.user akabox --auth.pass thisisapassword "
alias killremote="killall "Remote Desktop""
alias killntk="killall "NTKDaemon""

##alias creatersa="ssh-keygen -b 1024 -t rsa -f id_rsa -P """

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`




export PATH=$PATH:/Library/Developer/CommandLineTools/usr/bin/codesign_allocate

# Recursively delete `.DS_Store` files
# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete;sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent';say data cleaning up complete"

eval $(thefuck --alias)
alias f="fuck"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias airscan='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s'


#code sign
alias codesign='codesign --force --deep --sign - '



########################################################################################################################################

zsh_internet_signal(){
  #source on quality levels - http://www.wireless-nets.com/resources/tutorials/define_SNR_values.html
  #source on signal levels  - http://www.speedguide.net/faq/how-to-read-rssisignal-and-snrnoise-ratings-440
	local signal=$(airport -I | grep agrCtlRSSI | awk '{print $2}' | sed 's/-//g')
  local noise=$(airport -I | grep agrCtlNoise | awk '{print $2}' | sed 's/-//g')
  local SNR=$(bc <<<"scale=2; $signal / $noise")

  local net=$(curl -D- -o /dev/null -s http://www.google.com | grep HTTP/1.1 | awk '{print $2}')
  local color='%F{yellow}'
  local symbol="\uf197"

  # Excellent Signal (5 bars)
  if [[ ! -z "${signal// }" ]] && [[ $SNR -gt .40 ]] ;
    then color='%F{blue}' ; symbol="\uf1eb" ;
  fi

  # Good Signal (3-4 bars)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .40 ]] && [[ $SNR -gt .25 ]] ;
    then color='%F{green}' ; symbol="\uf1eb" ;
  fi

  # Low Signal (2 bars)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .25 ]] && [[ $SNR -gt .15 ]] ;
    then color='%F{yellow}' ; symbol="\uf1eb" ;
  fi

  # Very Low Signal (1 bar)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .15 ]] && [[ $SNR -gt .10 ]] ;
    then color='%F{red}' ; symbol="\uf1eb" ;
  fi

  # No Signal - No Internet
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .10 ]] ;
    then color='%F{red}' ; symbol="\uf011";
  fi

  if [[ -z "${signal// }" ]] && [[ "$net" -ne 200 ]] ;
    then color='%F{red}' ; symbol="\uf011" ;
  fi

  # Ethernet Connection (no wifi, hardline)
  if [[ -z "${signal// }" ]] && [[ "$net" -eq 200 ]] ;
    then color='%F{blue}' ; symbol="\uf197" ;
  fi

  echo -n "%{$color%}$symbol " # \f1eb is wifi bars
}

POWERLEVEL9K_CUSTOM_INTERNET_SIGNAL="zsh_internet_signal"
###################################################################################################################################
POWERLEVEL9K_MODE='awesome-patched'

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(icons_test)

#new command with new line
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

#right new line
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs  load ram swap battery history )
# for network status , we can add custom_internet_signal to the menu segments, but it will slow down the terminal

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# POWERLEVEL9K_COLOR_SCHEME='dark' #default is black

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B2'




#vcs
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '

POWERLEVEL9K_VCS_FOREGROUND="blue" # Dark blues

# Advanced `vcs` color customization
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'

POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"

POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch git-tagname)




#status



# command_execution_time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD="2"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION="3"



#root indicator


#jobs
POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE="true"
POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE_ALWAYS="true"

#load
POWERLEVEL9K_LOAD_WHICH="1"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="green"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="yellow1"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="red"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="white"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="yellow1"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="black"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"


#ram
POWERLEVEL9K_RAM_FOREGROUND='black'
POWERLEVEL9K_RAM_BACKGROUND='yellow'
POWERLEVEL9K_SWAP_FOREGROUND='black'
POWERLEVEL9K_SWAP_BACKGROUND='orange4'


#swap


# battery
POWERLEVEL9K_BATTERY_STAGES=($'\u2581 ' $'\u2582 ' $'\u2583 ' $'\u2584 ' $'\u2585 ' $'\u2586 ' $'\u2587 ' $'\u2588 ')
# POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(red1 orangered1 darkorange orange1 gold1 yellow1 yellow2 greenyellow chartreuse1 chartreuse2 green)
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND="white"
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND="grey"
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND="black"
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="green"
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND="black"
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="blue"
POWERLEVEL9K_BATTERY_LOW_THRESHOLD="20"
POWERLEVEL9K_BATTERY_LOW_FOREGROUND="white"
POWERLEVEL9K_BATTERY_LOW_BACKGROUND="red"


# time
POWERLEVEL9K_TIME_FOREGROUND="blue"
POWERLEVEL9K_TIME_BACKGROUND="black"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"



