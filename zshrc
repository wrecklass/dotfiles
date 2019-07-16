#!/usr/local/bin/zsh
################################# START MY DATA ##############################
# My personal vars
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export FZF_BASE='/usr/local/opt/fzf'

export GOROOT='/usr/lib/go'
export GOPATH="$HOME/src/gocode"
export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE="x:h:history:ls:ps:ll:exit"
export HISTSIZE=7000
export HISTFILESIZE=${HISTSIZE}
export NETREGX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
export LESS='FXR'
export LSCOLORS='Gxfxcxdxdxegedabagacad'
################################# END MY DATA ################################

# If we have wireless interface, make sure it isn't powered down.
WLINF="$(ifconfig  | sed  -n -e 's#^\(wl.*\):.*#\1#p')"
if [[ -n "$WNINF" ]];then
  sudo iwconfig "${WNINF}" power off
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:$GOPATH/bin:$PATH

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  battery
  common-aliases
  cp
  extract
  fzf
  git
  gnu-utils
  go
  history
  jsontools
  jump
  osx
  rand-quote
  rsync
  sudo
  thefuck
  tmux
  web-search
)

export POWERLINE_MODULES="user,host,ssh,cwd,perms,jobs,newline,kube,git,hg,exit,root"

function powerline_precmd() {
  PS1="$($GOPATH/bin/powerline-go -modules 'nix-shell,venv,user,host,ssh,cwd,perms,jobs,newline,git,hg,exit,root' -numeric-exit-codes -colorize-hostname -cwd-mode plain -error $? -shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
else
  source $HOME/.bash_prompt
fi

export EDITOR="/usr/bin/vim"
export PATH="/home/smartin/.local/bin:/usr/local/Cellar/coreutils/8.30/libexec/gnubin:$PATH"
export MANPAGES="/usr/local/Cellar/coreutils/8.30/libexec/gnuman:$PATH"
source $ZSH/oh-my-zsh.sh

# User configuration
#
# For local Rust install
MANPATH="/usr/share/man"
MANPATH+=":/home/smartin/.rustup/toolchains/beta-x86_64-unknown-linux-gnu/share/man"
export MANPATH
export PATH="$HOME/.cargo/bin:$PATH"

export MANPATH="/usr/local/man:$MANPATH"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
