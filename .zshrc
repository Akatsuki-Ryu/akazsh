# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=(git docker-compose autojump terraform)



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

# source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
 source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
 source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'


#config for the libmobiledevice log
export DYLD_LIBRARY_PATH=/Users/akatsuki/libmobiledevice/:$DYLD_LIBRARY_PATH
PATH=${PATH}:/Users/akatsuki/libmobiledevice/


################path for golang
export GOPATH=$HOME/go
alias zshconfig="subl ~/.zshrc"
alias aliasconfig="subl ~/akazsh/.aliases"

# Aliases source file
source $HOME/akazsh/.aliases

# android configure source file
source $HOME/akazsh/androidconf






export JAVA_HOME=`/usr/libexec/java_home -v 11`
export PATH="/usr/local/sbin:$PATH"



export PATH=$PATH:/Library/Developer/CommandLineTools/usr/bin/codesign_allocate



#####################################################################################################
##powerlevel9k configs
###################################################################################################

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
 export PATH="$(pyenv root)/shims:$HOME/local/bin:$PATH"



test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

