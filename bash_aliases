#!/usr/bin/env bash
# {{{ Logging
# If we've already read these, don't do it again, unless TMUX
if [ -z "$TMUX" ]; then
  [[ -z "${SET_ALIASES}" ]] && readonly SET_ALIASES=true || return 0
fi
_log ".bash_aliases"
_log "SHELL: $SHELL"
# }}}
# {{{ _colorflags
# Detect which `ls` flavor is in use
# export _colorflag="-G"
# if ls --color &> /dev/null ; then # GNU `ls`
_colorflag="--color=always"
# fi # OS X `ls`

if command -v colordiff &>/dev/null; then
  alias diff='colordiff'
  alias dif='colordiff'
else
  alias dif='diff'
fi

if [ "$UNAME" == "cygwin" ]; then
  alias wsl='wsl.exe'
  alias diff="diff --color"
  alias dif="diff --color"
fi
alias grep='grep -a --color=always'
alias gpre='grep -a --color=always'
alias grpe='grep -a --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# }}}
# {{{ cd aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias -- --="cd --"
# }}}
# {{{ common typos
# Because I'm occasionally dislexic:
alias cate='cat'
# Don't clear scrollback
alias clear='clear -x'
# alias clr='clear -x'
alias cls='clear -x'
alias clar='clear -x'
alias claer='clear -x'
alias cler='clear -x'
alias ''='clear -x'
# }}}
# {{{ Aliases

# Add an "alert" alias for long running commands.
# Sends a desktop notification when app has finished.
# Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dfh='df -h '
alias duh='du -sh'
alias dus='du -sh . | sort -h'
# alias dust='du -sh * | sort -h'

alias d='dirs -v'

alias fild='file'
alias fiel='file'
# {{{ git stuff
alias bit="git"
alias g="git"
alias get='git'
alias gut='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'

alias gcom='git switch master'
alias gcod='git switch dev'
alias gco='git checkout'
alias gcob='git checkout -b'

alias gc='git commit'
alias gcm='git commit'
alias gcmsg='git commit -m'
alias gcam='git commit -a -m'

alias gcf='git config --list'

alias gd='git diff'
alias gdw='git diff --word-diff'
alias giff='git diff'
alias gl='git log'
alias glp='git log -p'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gp='git push'
alias gpa='git remote | xargs -I X git push X --all'
alias gr='git remote'
alias grv='git remote -v'
alias gss='git status -s'
alias gs='git status'

alias gsu='git submodule update'
# }}}
alias hp='hashapass.sh'
alias lesb='$(history -p !!) | less'

alias irb='irb --readline -r irb/completion'

alias ppath='echo -e ${PATH//:/\\n}'

# {{{ IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
# }}}

# Overlaps with new alias for 'jump'
# alias j='jobs'

# {{{ File lists 'ls'
_LS='ls'
if command -v lsd &> /dev/null; then
  _LS='lsd'
fi
export _DF
_DF="--group-directories-first"

alias ls='${_LS} -F $_DF ${_colorflag}'
alias lltg='${_LS} -lGrtF $_DF ${_colorflag}'
alias llgt='${_LS} -lGrtF $_DF ${_colorflag}'
alias lg='${_LS} -lGF $_DF ${_colorflag}'
alias llg='${_LS} -lGF $_DF ${_colorflag}'
alias lt='${_LS} -lrtF $_DF ${_colorflag}'
alias llt='${_LS} -lrtF $_DF ${_colorflag}'

alias dot='${_LS} -A -dF ${_DF} ${_colorflag} .[a-zA-Z0-9]*'
alias dolt='${_LS} -A -dlF ${_DF} ${_colorflag} .[a-zA-Z0-9]*'
alias l.='${_LS} -A -dF ${_DF} ${_colorflag} .*'
alias ll.='${_LS} -ldF ${_DF} ${_colorflag} .*'
alias lf='/bin/${_LS} -F ${_DF} ${_colorflag}'
alias l='/bin/${_LS} -lGF ${_colorflag}'
alias lsa='${_LS} -A -F ${_DF} ${_colorflag}'
alias lsp='\${_LS} -F'
# alias la='${_LS} -AF ${_colorflag}'
alias ll='${_LS} -lF ${_DF} ${_colorflag}'
alias lla='${_LS} -A -lF ${_DF} ${_colorflag}'
alias lh='${_LS} -lhF ${_DF} ${_colorflag}'
alias llh='${_LS} -lhF ${_DF} ${_colorflag}'
# }}}
alias md='mkdir'
alias mdp='mkdir -p'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

alias nslookupo=nslookup
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

alias gitoh='open https://github.com/jandedobbeleer/oh-my-posh'

alias pp='ping 8.8.8.8'
# alias fastping='ping -c 10 -i .2'
alias r='fc -s'
alias ri='ri -f bs '
alias rit='ri -T -f bs '

alias res='printf "%s x %s\n" "$COLUMNS" "$LINES"'

alias rm='rm -i'
alias mr='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vm='mv -i'

alias sw='telnet  towel.blinkenlights.nl'
# alias sx='startxwin.sh &> .xwin_errors'

alias untar='tar xvf'
alias xtar="tar xvf"
alias ctar="tar cvf"
alias ttar="tar tvf"
alias ttc='tty-clock -scxBC 6'

# More typo fixing
alias ssu='ssh'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# URL-encode strings
# alias urlencode='python -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]));"'

alias vs='vim -S $HOME/.config/vim/Session.vim'
alias vis='vim -S $HOME/.config/vim/Session.vim'

alias week='date +%V'
alias wcl='wc -l'

alias httpd.py='python -m SimpleHTTPServer'
alias httpd.rb='ruby -run -e httpd . -p 8000'

# Because we do this so often
alias xit='exit'

# alias xh='xhost +'
alias x='chmod a+rx'

# Weather Underground
alias wuf='open https://www.wunderground.com/forecast/us/co/aurora/KCOAUROR322'
alias wu='open https://www.wunderground.com/weather/us/co/aurora/KCOAUROR322'

alias muffins='open '\''https://www.amazon.com/Katz-Gluten-Free-English-Muffins/dp/B07N1WSDC8/ref=sr_1_1_pp?s=grocery&sr=1-1'\'''
alias orders='open "https://www.amazon.com/gp/css/order-history"'
# }}}
# {{{ Completions
# So these two aliases do bash_completion from git
__git_complete g git
__git_complete get git
__git_complete gut git
__git_complete ga git_add
__git_complete gaa git_add
__git_complete gc git_commit
__git_complete gcm git_commit
__git_complete gco git_checkout
__git_complete gp git_push
__git_complete gpa git_push
__git_complete gl git_log
__git_complete gd git_diff
__git_complete gf git_fetch
# }}}
# {{{ fzf and bat aliases
# Use fzf with a preview window
if command -v bat &>/dev/null; then
  alias pf='fzf --preview="bat --color=always --decorations=always {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
elif command -v batcat &>/dev/null; then
  alias pf='fzf --preview="batcat --color=always --decorations=always {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
else
  alias pf='fzf --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
fi
# }}}
# {{{ Vim config
if [ -x "$HOME/bin/vim" ]; then
  alias sec='$HOME/bin/vim $HOME/bin/.secret'
elif [ -x /usr/local/bin/vim ]; then
  alias sec='/usr/local/bin/vim $HOME/bin/.secret'
else
  alias sec='/usr/bin/vim $HOME/bin/.secret'
fi
alias svi='sudo vim'
# alias via='vi ~/.ssh/assh.yml'

if [ -z "$EDITOR" ]; then
  if [ -x "/bin/vim.basic" ]; then
    EDITOR="/bin/vim.basic"
  elif [ -x "/bin/vim.tiny" ]; then
    EDITOR="/bin/vim.tiny"
  fi
fi
alias vi="\$EDITOR"
alias vim="\$EDITOR"
alias vimrc="\$EDITOR \${HOME}/.vimrc"
alias vib="\$EDITOR ~/.bashrc"
alias iv="\$EDITOR"
# }}}
# {{{ Hub tool
hub_path=$(command -v hub)
if [ -n "${hub_path}" ]; then
  # alias git="${hub_path}"
  eval "$(hub alias -s "$SHELL")"
fi
# }}}
# {{{ Duck Duck Go Search
declare -x BRAVE
if [ "$UNAME" == "cygwin" ]; then
  if [[ -x "/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe" ]]; then
    BRAVE="c:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"
  fi
else
  BRAVE="$(command -v brave)"
  if [ -z "$BRAVE" ]; then
    BRAVE="$(command -v brave-browser)"
  fi
fi

if [ -n "$BRAVE" ]; then
  alias ddgr='ddgr -n 8 --url-handler "$BRAVE"'
else
  _log "No brave found!"
fi
# }}}
