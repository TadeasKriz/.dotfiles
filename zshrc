# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/TadeasKriz/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler osx rake ruby pod xcode git-flow jira fabric sudo rvm wd zsh-autosuggestions zsh-syntax-highlighting)

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi
#ssh-add -K ~/.ssh/id_rsa
export ANDROID_HOME=/Users/tadeaskriz/Development/Tools/Android/SDK
export JAVA_HOME=$(/usr/libexec/java_home)
export DEV_HOME=/Users/TadeasKriz/Development


[ -s "/Users/tadeaskriz/.jabba/jabba.sh" ] && source "/Users/tadeaskriz/.jabba/jabba.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/.scripts"
export RELEASE_ACCESS_TOKEN=162952a8dfda9c69744890a057a10aa0d29c1519
export GITHUB_USERNAME=TadeasKriz


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

eval "$(pyenv init -)"

alias please="sudo"
alias lg='lazygit'
alias pi='pod install'
eval "$(rbenv init -)"

# eval "$(jenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/tadeaskriz/.sdkman"
[[ -s "/Users/tadeaskriz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tadeaskriz/.sdkman/bin/sdkman-init.sh"

function xcode-versions () {
    ls -l /Applications/Xcodes | grep '.app' | awk '{print $NF}' | sed 's/.app$//' | sed 's/^Xcode//'
}

function xcode-list () {
    xcode-versions | awk '{print "  - Xcode " $0;}'
}

function xcode () {
    open /Applications/Xcode.app
}

function xcodes () {
  if (( $# == 0 ))
  then
    echo "Available Xcodes:" 
    xcode-list
  else
    if $(xcode-versions | grep -qw "$1")
    then
      echo "Switching to $1"
      XCODE_PATH="/Applications/Xcodes/Xcode$1.app"
      sudo xcode-select -s "$XCODE_PATH"
      rm /Applications/Xcode.app
      ln -s "$XCODE_PATH" /Applications/Xcode.app
    else
      echo "Xcode named $1 not found!\nAvailable Xcodes:"
      xcode-list
    fi  
  fi
}

function fixdisplay () {
#  displayplacer "id:4D57A90C-547F-BB9E-06A1-2278E532330C res:2560x1440 hz:59 color_depth:8 scaling:off origin:(0,0) degree:0" "id:CDA4218F-08C5-A851-8749-713B265C02F1 res:1440x2560 hz:59 color_depth:8 scaling:off origin:(-1440,-548) degree:90" "id:2435A40A-27FA-C6B8-76BA-E051A4D8C96A res:1440x2560 hz:59 color_depth:8 scaling:off origin:(2560,-569) degree:270"
  displayplacer "id:8D4AFB36-EE4E-B48E-059A-FEB5EC8D4620 res:2560x1440 hz:60 color_depth:8 scaling:off origin:(0,0) degree:0" "id:CDA4218F-08C5-A851-8749-713B265C02F1 res:1440x2560 hz:59 color_depth:8 scaling:off origin:(-1440,-1120) degree:90" "id:2435A40A-27FA-C6B8-76BA-E051A4D8C96A res:1440x2560 hz:59 color_depth:8 scaling:off origin:(2560,-1120) degree:270" "id:1CDA4534-FD86-B714-CACB-390248F4D40A res:2560x1440 hz:59 color_depth:8 scaling:off origin:(0,-1440) degree:180"
}

function fixdisplayus () {
  displayplacer "id:FCCAFD4E-7795-1C64-CA96-7F02B819CF09 res:1920x1080 hz:60 color_depth:8 scaling:on origin:(0,0) degree:0" "id:7A44E631-49E0-E333-BC96-E9D85A15F6FF res:1080x1920 hz:60 color_depth:8 scaling:on origin:(-1080,-340) degree:90" "id:CDABDD96-616F-31FD-D133-9A25E73F5A5A res:1080x1920 hz:60 color_depth:8 scaling:on origin:(1920,-396) degree:90"
}

function fixdisplayusbc () {
  displayplacer "id:4D57A90C-547F-BB9E-06A1-2278E532330C res:2560x1440 hz:59 color_depth:8 scaling:off origin:(0,0) degree:0" "id:CDA4218F-08C5-A851-8749-713B265C02F1 res:1440x2560 hz:59 color_depth:8 scaling:off origin:(-1440,-1120) degree:90" "id:2435A40A-27FA-C6B8-76BA-E051A4D8C96A res:1440x2560 hz:59 color_depth:8 scaling:off origin:(2560,-1120) degree:270" "id:1CDA4534-FD86-B714-CACB-390248F4D40A res:2560x1440 hz:59 color_depth:8 scaling:off origin:(0,-1440) degree:180"
}

export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com/" || mkdir -p "${GOPATH}/src/github.com"

export GOPATH=$HOME/.go

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
